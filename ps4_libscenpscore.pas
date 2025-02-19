unit ps4_libSceNpScore;

{$mode objfpc}{$H+}

interface

uses
  ps4_program,
  Classes, SysUtils;

implementation

function ps4_sceNpScoreCreateNpTitleCtx(npServiceLabel:Integer;selfId:Integer):Integer; SysV_ABI_CDecl;
begin
 Result:=0;
end;

function ps4_sceNpScoreCreateRequest(titleCtxId:Integer):Integer; SysV_ABI_CDecl;
begin
 writeln('ScoreCreateRequest:',titleCtxId);
 Result:=894;
end;

function ps4_sceNpScoreDeleteRequest(reqId:Integer):Integer; SysV_ABI_CDecl;
begin
 writeln('sceNpScoreDeleteRequest:',reqId);
 Result:=0;
end;

const
 SCE_NP_ONLINEID_MIN_LENGTH=3;
 SCE_NP_ONLINEID_MAX_LENGTH=16;

type
 SceNpOnlineId=packed record
  data:array[0..SCE_NP_ONLINEID_MAX_LENGTH-1] of Char;
  term:Char;
  dummy:array[0..2] of Char;
 end;

 PSceNpScoreRankDataA=^SceNpScoreRankDataA;
 SceNpScoreRankDataA=packed record
  onlineId:SceNpOnlineId;
  reserved0:array[0..15] of Byte;
  reserved:array[0..48] of Byte;
  pad0:array[0..2] of Byte;
  pcId:Integer;
  serialRank:DWORD;
  rank:DWORD;
  highestRank:DWORD;
  hasGameData:Integer;
  pad1:array[0..3] of Byte;
  scoreValue:Int64;
  recordDate:QWORD;
  accountId:QWORD;
  pad2:array[0..7] of Byte;
 end;

const
 SCE_NP_SCORE_COMMENT_MAXLEN=63;

type
 PSceNpScoreComment=^SceNpScoreComment;
 SceNpScoreComment=packed record
  utf8Comment:array[0..SCE_NP_SCORE_COMMENT_MAXLEN] of Char;
 end;

const
 SCE_NP_SCORE_GAMEINFO_MAXSIZE=189;

type
 PSceNpScoreGameInfo=^SceNpScoreGameInfo;
 SceNpScoreGameInfo=packed record
  infoSize:size_t;
  data:array[0..SCE_NP_SCORE_GAMEINFO_MAXSIZE-1] of Byte;
  pad2:array[0..2] of Byte;
 end;

 PSceNpScoreGetFriendRankingOptParam=^SceNpScoreGetFriendRankingOptParam;
 SceNpScoreGetFriendRankingOptParam=packed record
  size:size_t;
  startSerialRank:PInteger;
  hits:PInteger;
 end;

function ps4_sceNpScoreGetFriendsRanking(
            reqId:Integer;                                                       //1
            boardId:DWORD;                                                       //2
            includeSelf:Integer;                                                 //3
            rankArray:PSceNpScoreRankDataA;                                      //4
            rankArraySize:size_t;                                                //5
            commentArray:PSceNpScoreComment;                                     //6
            commentArraySize:size_t;                                             //7
            infoArray:PSceNpScoreGameInfo;                                       //8
            infoArraySize:size_t;                                                //9
            arrayNum:size_t;                                                     //10
            lastSortDate:PQWORD;                                                 //11
            totalRecord:PDWORD;                                                  //12
            option:PSceNpScoreGetFriendRankingOptParam):Integer; SysV_ABI_CDecl; //13
begin
 //lastSortDate^:=0;
 //totalRecord^:=0;
 Result:=0;
end;

type
 PSceNpScoreAccountIdPcId=^SceNpScoreAccountIdPcId;
 SceNpScoreAccountIdPcId=packed record
  accountId:QWORD;
  pcId:Integer;
  pad:array[0..3] of Byte;
 end;

 function ps4_sceNpScoreGetRankingByAccountIdPcId(
             reqId:Integer;
             boardId:DWORD;
             idArray:PSceNpScoreAccountIdPcId;
             idArraySize:size_t;
             rankArray:PSceNpScoreRankDataA;
             rankArraySize:size_t;
             commentArray:PSceNpScoreComment;
             commentArraySize:size_t;
             infoArray:PSceNpScoreGameInfo;
             infoArraySize:size_t;
             arrayNum:size_t;
             lastSortDate:PQWORD;
             totalRecord:PDWORD;
             option:Pointer):Integer; SysV_ABI_CDecl;
begin
 Result:=0;
end;

function Load_libSceNpScoreRanking(Const name:RawByteString):TElf_node;
var
 lib:PLIBRARY;
begin
 Result:=TElf_node.Create;
 Result.pFileName:=name;
 lib:=Result._add_lib('libSceNpScore');
 lib^.set_proc($2A7340D53120B412,@ps4_sceNpScoreCreateNpTitleCtx);
 lib^.set_proc($816F2ACA362B51B9,@ps4_sceNpScoreCreateRequest);
 lib^.set_proc($74AF3F4A061FEABE,@ps4_sceNpScoreDeleteRequest);
 lib^.set_proc($F24B88CD4C3ABAD4,@ps4_sceNpScoreGetFriendsRanking);
 lib^.set_proc($F66644828884ABA6,@ps4_sceNpScoreGetRankingByAccountIdPcId);
end;

initialization
 ps4_app.RegistredPreLoad('libSceNpScoreRanking.prx',@Load_libSceNpScoreRanking);

end.

