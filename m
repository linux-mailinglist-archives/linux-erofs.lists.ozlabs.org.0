Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EEA28F36B
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Oct 2020 15:38:44 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CBr3541rGzDqQd
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Oct 2020 00:38:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.50;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppoglobal.onmicrosoft.com
 header.i=@oppoglobal.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=RGObRT08; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320050.outbound.protection.outlook.com [40.107.132.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CBr2s6sYdzDqMm
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Oct 2020 00:38:24 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EM9s5y21Q8Mz8byqkgVep/wK3UNWeGSqCuHedZJgOYl9ijE9o0x0+GzsAW8LpoNOODv6N874ktyEIZ0wm5RyDB1roBZbwR0vTGNpTJHdUJPaalPzxjE+xU5J99/NsVvauQNg5busDsc0Ui+15GxoxTRiZ9CFfzGcBpjuvk2+SCZv1wIgdUA69Lo8/KQFDEoEBNqRAqF1tRWk43DwNPRe1GpgGqtJZufOS+ZmeaBVvrv71pNuS143X5lc+EshsxXpg2j59cFP13d4svnS3u+V6cYBg89oRRzHaBRtL+BNNLS7AoyTpuoF9nelH5fk7kTg7Mkb4n3q6itp0AoUwP5oow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQFrMnr1TAc+rvtBwp0CzOx1M8XxfHgXZTWoaQr1C2s=;
 b=Jz1XUt4bBkQgLXgKBlVweYhf8bZkcgyLF1IHDo90pYLj/6fRqrRR52o0x/vT9v6NaIMsQrBqEI7piHVXx6NDO2f8xp10D4D+VmpchtJGiR4gNT925v2M4IMvTaAjZhcoMKnwqH3jmTLkcfLM39qYbTLQtpa/26MpOH8OPTDd444DojEEEcE2F+hfsTv3TVr1X9w37KkgsKtIufY7VteigrHsdqVAQ7RIyCM/Obm9OvzudSaNzr8RHogcFgegtyG/xIQk8ygm1jzDZEEEbXlcI02GD2M/kV2qSdoweUVjWJ8JKOqMFOB5bliEMG+SME8CyTMWUOb+EIFk09JLPvqKig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQFrMnr1TAc+rvtBwp0CzOx1M8XxfHgXZTWoaQr1C2s=;
 b=RGObRT08xzv74aVLxEULvoaR8CA+seRvfoGgundyOtMdrSCkhgcSvDVp1qzkQ6ExMSM1xYo8ucR/UavKYr2+voBiOn/+L3bFJ6keq6HLW2H751BpZVPwziH0Qbgqni8dMcKcFPISBfHPNnHzABW/4xiOVcFrT4zmInfeX00fwCQ=
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2383.apcprd02.prod.outlook.com (2603:1096:3:1b::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.22; Thu, 15 Oct 2020 13:38:06 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::21c8:750e:8135:b142]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::21c8:750e:8135:b142%5]) with mapi id 15.20.3477.022; Thu, 15 Oct 2020
 13:38:06 +0000
From: Huang Jianan <huangjianan@oppo.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 0/5] erofs-utils: support read special file and compressed
 file for fuse framework
Date: Thu, 15 Oct 2020 21:37:41 +0800
Message-Id: <20201015133741.60943-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [58.255.79.104]
X-ClientProxiedBy: HK0PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::13) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.255.79.104) by
 HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend
 Transport; Thu, 15 Oct 2020 13:38:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4acec429-9621-471f-32ff-08d8710f8c28
X-MS-TrafficTypeDiagnostic: SG2PR02MB2383:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB23836F79A5FF83CE2CD1CBE7C3020@SG2PR02MB2383.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zVUd36ebjmRVMtaErNp6slGNoBZHq0o8vJW41of6zehdNZQfqrwaWSxqPlL3B08tQvzjr4ON0H65jko4O5dSk98MRyPc9QLN/QuxjGZlbXZs9frF+0O08eZObwYYqO716Bfjuj+wxuddY2lhT89eP/SYqrRoygDRgoR8YOQY8mDzcjXMPb600wOBZFAOaQq5hVU72FE9SrvtXpwywZoktLsXaEvrnIJ59AD73+IYnmt9415kPE1deT7f3v2yLP0baj4jzBbkHb1qUeEWQzYtFEc6TSSurCurnfCZLeT88WBTc6zXMS7Ev7WvX972QPq9sBhYeRkblsnRgLtuhhBnGPXvat9ARl72VE8PqayjvXusDvTQzRS2UpR2gJuEYdD6aoSHSGZ8SGPm9KecX8iJXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(478600001)(86362001)(83380400001)(34490700002)(26005)(186003)(16526019)(36756003)(6512007)(4326008)(6506007)(6916009)(5660300002)(316002)(1076003)(52116002)(8676002)(6486002)(2906002)(8936002)(66476007)(6666004)(66946007)(66556008)(956004)(107886003)(2616005)(11606004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: nVu7QeFARKtApwNirYuHBictxy3GCTm9TtjT3eib+B+R4rVKmHvLxrx2M+Li1wYwaanwPrYqvkBU7byuspvtEbx6ds6fActbGSx21qbZqH60J632KJKSeqCnqCVE2AQ8rFuB0iaPwp0wnEqn4BYB7ROPPKkpE2TCHsHgxOnN84dY9twV6fGrwu+BnVGFYgSYU0rm0MIXQODljiI+WHmBaCRVI+XaMPGsNmO40veZNowSXxwS+2DmexVSHJLV1i72ajiINZD+lUH432JNf3rE61wVYhfD0BTYMwrFB/cH71Eo0tRWoRMLxMgnSoAhBF1PvCGMlqGuE/tk7j8yfWBQaSoU/etBp8fcqF0LhxR0OEnxOkfF9LdOK7+pmjhvSnSDvAUWBubqGYAk1b4LMqYrjmAxwKdzOXuerTS4Fwn1u9GqBPczkaRW79aquBlbnr12k8v7vUTE7msLOXEqkm8ddtR/pO7AqymPzxI/0jL4y3tJnRpOhIVxjKrB1s1OZfvPbSnXX/rxhyUQQSaxlQJJJkRkHGv0Sr0t4nai4dNLkdFvGsT7EKA5+8JfvpGK/8jls72yzajPGRJHlmLemutkNNI7Lo/xxdVgVWKvdt1rwShLdtX2RczMzvkpa6+omr2A3UUuu+V1dw0i84kUhjEIEA==
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4acec429-9621-471f-32ff-08d8710f8c28
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 13:38:06.5016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n54JFVeqybD3rz0MUjpgpbPWQGxJFoNfdx6yszmwYRwrt5crCBerjGAWgDSy2o2GJvZwk72TaD0JGnko+fehJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2383
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: guoweichao@oppo.com, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fix some bugs in directory tree parsing.
Support read special file and compressed file now.

Huang Jianan (5):
  erofs-utils: fix the conflict with the master branch
  erofs-utils: fix the wrong name length of tail file in the directory
  erofs-utils: fix the wrong address of inline dir content.
  erofs-utils: support read special file
  erofs-utils: support read compressed file

 fuse/Makefile.am         |   7 +-
 fuse/decompress.c        |  86 ++++++++
 fuse/decompress.h        |  38 ++++
 fuse/dentry.h            |   5 +-
 fuse/getattr.c           |   1 +
 fuse/init.c              |  26 ++-
 fuse/init.h              |   2 +
 fuse/main.c              |   1 +
 fuse/namei.c             |  50 +++--
 fuse/read.c              | 103 +++++++++-
 fuse/read.h              |   1 +
 fuse/readir.c            |  18 +-
 fuse/zmap.c              | 416 +++++++++++++++++++++++++++++++++++++++
 include/erofs/defs.h     |  13 ++
 include/erofs/internal.h |  50 ++++-
 include/erofs_fs.h       |   4 +
 16 files changed, 781 insertions(+), 40 deletions(-)
 create mode 100644 fuse/decompress.c
 create mode 100644 fuse/decompress.h
 create mode 100644 fuse/zmap.c

--
2.25.1

________________________________
OPPO

=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=
=BB=B6=E5=90=AB=E6=9C=89OPPO=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=86=
=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E9=82=AE=E4=BB=B6=E6=
=8C=87=E6=98=8E=E7=9A=84=E6=94=B6=E4=BB=B6=E4=BA=BA=E4=BD=BF=E7=94=A8=EF=BC=
=88=E5=8C=85=E5=90=AB=E4=B8=AA=E4=BA=BA=E5=8F=8A=E7=BE=A4=E7=BB=84=EF=BC=89=
=E3=80=82=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E4=BA=BA=E5=9C=A8=E6=9C=AA=E7=
=BB=8F=E6=8E=88=E6=9D=83=E7=9A=84=E6=83=85=E5=86=B5=E4=B8=8B=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=E3=80=82=E5=A6=82=E6=9E=9C=
=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=
=AF=B7=E7=AB=8B=E5=8D=B3=E4=BB=A5=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E9=80=
=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E3=80=82

This e-mail and its attachments contain confidential information from OPPO,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you re=
ceive this e-mail in error, please notify the sender by phone or email imme=
diately and delete it!
