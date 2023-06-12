Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CC572CECF
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Jun 2023 20:56:43 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=utah.edu header.i=@utah.edu header.a=rsa-sha256 header.s=UniversityOfUtah header.b=INYroLwP;
	dkim=pass (1024-bit key; unprotected) header.d=UofUtah.onmicrosoft.com header.i=@UofUtah.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-UofUtah-onmicrosoft-com header.b=LThF/0P7;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qg1BJ71sqz30Jl
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Jun 2023 04:56:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=utah.edu header.i=@utah.edu header.a=rsa-sha256 header.s=UniversityOfUtah header.b=INYroLwP;
	dkim=pass (1024-bit key; unprotected) header.d=UofUtah.onmicrosoft.com header.i=@UofUtah.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-UofUtah-onmicrosoft-com header.b=LThF/0P7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=utah.edu (client-ip=155.97.144.30; helo=ipo5.cc.utah.edu; envelope-from=khagan.karimov@utah.edu; receiver=lists.ozlabs.org)
Received: from ipo5.cc.utah.edu (ipo5.cc.utah.edu [155.97.144.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qg1BC3PMDz30Jl
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Jun 2023 04:56:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=utah.edu; i=@utah.edu; q=dns/txt; s=UniversityOfUtah;
  t=1686596196; x=1718132196;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=8qCy7E40aBMzczhjL1OzfdIfvijOtdYmPydovq6KLwA=;
  b=INYroLwPHROdWonkdPLp748+pbFWIPPGZWVBn7YNlVqNHfYFbcaSuIJj
   13TMksA0iAl4eGPbC0Nuwo/EVJlmw1XY7IoxE/QuWr2JKHyMxoniG5wyf
   ARKwNGEHo5QMHbkmnLCIgItnzrnotcL7bJdKn4yUcaBUfKInQXzA4KfqR
   fjKb1i1QXWdoW0BBY0a83zYAOsEmcranBFRsMhfaPbA8dv1OtX37M767Y
   EyLyMg95DH48pQ24efff/tXN5EUp9WbrOA0Zo0xWprOnMKG0xQH8O5mRo
   ojmKUahjhmtmbkx3ftl3d4di3i9t6xdYePIdB1U7CTYMxYPfo0leUwS9i
   w==;
X-IronPort-AV: E=Sophos;i="6.00,236,1681192800"; 
   d="scan'208";a="625225697"
Received: from iso-dlpep-p07.iso.utah.edu ([10.71.25.187])
  by ipo5smtp.cc.utah.edu with ESMTP; 12 Jun 2023 12:55:21 -0600
Received: from iso-dlpep-p07.iso.utah.edu (iso-dlpep-p07.iso.utah.edu [127.0.0.1])
	by iso-dlpep-p07.iso.utah.edu (Service) with ESMTP id 5C6F75735;
	Mon, 12 Jun 2023 12:55:18 -0600 (MDT)
Received: from UMAILX-M201.xds.umail.utah.edu (unknown [172.31.233.10])
	by iso-dlpep-p07.iso.utah.edu (Service) with ESMTP id 428EC577A;
	Mon, 12 Jun 2023 12:55:18 -0600 (MDT)
Received: from UMAILX-M206.xds.umail.utah.edu (155.97.144.206) by
 UMAILX-M201.xds.umail.utah.edu (155.97.144.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 12 Jun 2023 12:55:18 -0600
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 UMAILX-M206.xds.umail.utah.edu (155.97.144.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34 via Frontend Transport; Mon, 12 Jun 2023 12:55:18 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J80yU/z+r1GkF+8k33UVItGBQcLhAIulctqAxuYKe5hDtKVc81YDFvWkzepvApaX0N0EwTkx2+FcPVankZFH9Ag44tg6RP7OwioB5nhE+M//meUetrlq/TBQTD38vZOPq3UFY1DRTUkS5uKiYK3Zaj9AUmVv01qvz4lEwNX3pMZfcG9qUc/VXP5LyI55yWeckqyKT/gxoOqpJM/E/98Q/n7xvOtQyhPEXFEN05yd4cJFQ+M3VDfKfdI1a0FeL0TurhX4MrH4UEbGDkjYnndCZ0oQWTVhti3WyQrLQEtmn1D70m0bTKlsqOzwfYZwOBcR3HvO54bvfUP2RX9zNV6w+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3+wnZa4zczEdRALSlRT44MZh1LxNFK2IMMjfojVi2E=;
 b=UI2/kDBDob/M66bmcCzQueMjYusfa46TW+ASf8/fEzMGvOd8IqkyB12u+hIRtew4VXM/gD2kz/37M0Eh7EcBlidsL3HrZLbzyKlm2vSmCZmURDNIAga9tcCEWSp5WHNYxa0xeGeLr5elLRH0IcJmC9aeG79InShr/F8+aFn82/Fc8XxAwkuiHxcZrkLfpwUOE3vCZW4jxlz1GcB09qv4T7F5pFtjMQ8ETkaHL4E2Wev3a9FLh+t3tngdLTiX2p3ZDUfsWrFMAsPOchQ1yPqY/PvkRxezoaEXJcOMjqiyA5nAjjzonXkBZwsMI9XC2PeRyN6eZQSqxXoVOD9NLNlPjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=utah.edu; dmarc=pass action=none header.from=utah.edu;
 dkim=pass header.d=utah.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=UofUtah.onmicrosoft.com; s=selector2-UofUtah-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3+wnZa4zczEdRALSlRT44MZh1LxNFK2IMMjfojVi2E=;
 b=LThF/0P741kDaD2oLGJ4s+QFV59PkXmJFrsyv0A0WDKNW+9QAZjqtfKffKCu0bnGNFgHL8Pc9w9/HscLQYA7cGLI9S+u1TMprJY8lHu58e3CiQ2/g+2vJXkojwTe6qoaOSjn2E9vFqaD9hU8J6gLc46EBAtKPk8riUQBFZLj54U=
Received: from DM5PR11MB0057.namprd11.prod.outlook.com (2603:10b6:4:6b::12) by
 CY5PR11MB6414.namprd11.prod.outlook.com (2603:10b6:930:36::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.28; Mon, 12 Jun 2023 18:55:16 +0000
Received: from DM5PR11MB0057.namprd11.prod.outlook.com
 ([fe80::5119:1550:791d:b329]) by DM5PR11MB0057.namprd11.prod.outlook.com
 ([fe80::5119:1550:791d:b329%4]) with mapi id 15.20.6455.034; Mon, 12 Jun 2023
 18:55:16 +0000
From: Khagan Karimov <Khagan.karimov@utah.edu>
To: "xiang@kernel.org" <xiang@kernel.org>, "chao@kernel.org"
	<chao@kernel.org>, "huyue2@coolpad.com" <huyue2@coolpad.com>,
	"jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
	"linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: general protection fault in erofs_bread
Thread-Topic: general protection fault in erofs_bread
Thread-Index: AQHZnV7yn6hm9QdUQ0eDC+RrprVQaQ==
Date: Mon, 12 Jun 2023 18:55:16 +0000
Message-ID: <DM5PR11MB00577D17A39E59923E92532FE954A@DM5PR11MB0057.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=utah.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR11MB0057:EE_|CY5PR11MB6414:EE_
x-ms-office365-filtering-correlation-id: 9bfc720a-23b7-4974-1296-08db6b768ff5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: unnIaJP/aUUSxInmBRybbsAhHe4yNE8Cw0NQlJoxtob6MRgWKNcuXKRMuqls80za93QfCkpVH3ZgfI/zdPaEEhg4EOkRTIjKTGKPN9B9FW21OCiQrJVi9onBTxEkHNhWWgWo69LrtgdgdCB00sIvwQSXt5KEgCuiEK9wKH6bSs8zapLsNwjhma4uJIIP/PJUOdG1iAf5UmBq5pdQfjmiEdNMZksIVdNonLpyLLpiK5BNxSGEgroM9S3GzR2gE3sPO17B7WTmnk14Q5Lzs6FDg71Rol35wmeDgkAXleKg/YDB/3v9pvT0l2QwJNX6frNDrSjXPKDVRZs9NwtM95nU9PtyRz91Wp4eK8v93+BVVkkwNkuppoqvrTdX7QLr02FZ8hwWyIyxTi84xRDS8Fk9x8ik3pfJ7aqP/18p/qtAJr5dzw5I3Xa0/GUoZi5CgZZbWu6TnQrrtVV8sGwTd6YklDEgzi16ZjqSjuIsHkTka50JOpCgw5aNsqTqKoHkAUOJz7yY/GvuSaDSSweItNKOOMcPD9CHoAG2p63xyvBe4ZD8h+ykIdj0ENxJ5o0IZuSd8bkhaaV8lvvawp39gw0yKYzDVeuXooEoaD7CjGFTcXs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB0057.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(41300700001)(45080400002)(2906002)(478600001)(75432002)(33656002)(7696005)(966005)(71200400001)(38070700005)(26005)(38100700002)(9686003)(6506007)(122000001)(86362001)(186003)(786003)(316002)(4326008)(91956017)(83380400001)(5660300002)(8676002)(8936002)(76116006)(66946007)(110136005)(66476007)(64756008)(66556008)(66446008)(52536014)(55016003)(5930299015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XXvewm8/dC9Hi3CNoium6y2Pyho4OUMA2IvpxIxGY4P2tXhPPSMgQW/tuU?=
 =?iso-8859-1?Q?kvVIulXz4Uzupb8FbbGf0YESm/GQR0055GA9/Hm3t4TM9jQrsUMsJrsBf1?=
 =?iso-8859-1?Q?FA3VHeln4+0Z3BSK/k3+W6CbPk/OCiiPRkJr2UOsXDSiMPrd0WcowI0Xud?=
 =?iso-8859-1?Q?PkKwcxzyOSRwEKbCSYHRQX0pWFqwh4lTQFiewzeZOzTXfQL3zj31ODcoSb?=
 =?iso-8859-1?Q?utljWiuolqCBila33DppnB0pqDZltYOIqjvGuQoBQNsJuft8PwjT8r9FTU?=
 =?iso-8859-1?Q?TwfEmrwn5JRmUcBo8R8NqqWCSG8uFOGCvzR5foXdRQmx+nHKidvwV1J8hs?=
 =?iso-8859-1?Q?7OXwXkOPbs7GSr8nsABVCZObLs5nXv2UfFOTqFNmhoN5rkOLkXQtHhHoOd?=
 =?iso-8859-1?Q?/66mdbAcdNNDYiS2l0mLpXLnHBJOXWQvaqi8Q6H7HFtxgqPYaOUDB84HkO?=
 =?iso-8859-1?Q?UHYc901hHPqVZzYW+QQ97vVElWzMdm/eGfX5AAcr76BPNUp9R6E9V9u+kr?=
 =?iso-8859-1?Q?SqRwDIVxkDIrvacPf/RFlbL6B2azhD3/Mdi2bFqPcoE33ihs2T1OkJAIRL?=
 =?iso-8859-1?Q?WafAwfBtlN/F27Za4y4AVCSKuO45KqNAyy9brHAR6kNpigX4dlS+ByGzTp?=
 =?iso-8859-1?Q?aeJX5TEa3d40oHQCFkQnmetZsjA0exWK/TjMM7wq53/S9ModQ17eqc54G4?=
 =?iso-8859-1?Q?jVAwkP0fYor5+hecQ8zeFNj9+fsdzqYOAliVRpLD2IHlNabzAOs/UajrkS?=
 =?iso-8859-1?Q?il8ZWYiWkBZ/CmnplcUZvCCJ0OzDkdOSSzjH2JBcHUGsYm1B2U2Cc4PaWW?=
 =?iso-8859-1?Q?dcvbbLh2wAqaP1f//WyTC6+cxMFYDGAlqzagFhNyK44Ierd1CH7fGvzWn8?=
 =?iso-8859-1?Q?BCUZj2J1LnqCoK77sinNJzd7dZz8NWjIYyQUVeMzhHhAHfurOIaKevmzv6?=
 =?iso-8859-1?Q?W19QR6i+gMiFs9sfkbgy8CdfjOL7ECyYeGh5pQBnMsOZElrtIm+I2A+g56?=
 =?iso-8859-1?Q?hvG2o0ou7g6UVcCHvsfUekisVqNISxp+VvuYmnPYctLUcRyb5887Ud22jz?=
 =?iso-8859-1?Q?ZOZfkvaL502JS6uq+hCZtw1GjY5+bIQz1nA2tl/FZDdveUMaf3bYHAOT4X?=
 =?iso-8859-1?Q?nvUgnpIb3asM13PRWTOWl4c5ARO+Y9bdHuwSCyCAyTh4Sis/Nbu6N2QfhD?=
 =?iso-8859-1?Q?omAnyvqBNw4S3b+9r0ghT84V46DUEplo2LbQ1KvrJQqtvSkxvCm/O8oVmM?=
 =?iso-8859-1?Q?JSETOQP3XhXDNsnFFn3z7cwY3KIuW1lZ4WJ/zMDkbH6SZdTUJ7fv+jjxpB?=
 =?iso-8859-1?Q?Dc4UhM47fet2PgDLW+9ygfDnviO3B8x4ndctPMn9Kf7U4rwKUyuEiag8+B?=
 =?iso-8859-1?Q?YkgWi2pmMunAOiezf4xNwlCmAyWPOkMaeoba8Pit2lHYsDpoCvAmNzHCoI?=
 =?iso-8859-1?Q?TPoLmYvlsGW21xdrd+ObNnoOjzkWctKCDZY/r3vQoADScbwEEmVohd7uBK?=
 =?iso-8859-1?Q?RUd1iIwFQKHsQnmmLTl4W2juUM1PpLg1WzHXU0uVs8W9+PT3rQBYMObbsA?=
 =?iso-8859-1?Q?Sacz60R1boCAlKB9Lit7lHUXGBrAGyBZTrOZfvREnvQ4h4nBqR9t4gC977?=
 =?iso-8859-1?Q?Vtsz+HdgxSI/bL6RLc6rgN1w5W93lz5yCe?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB0057.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfc720a-23b7-4974-1296-08db6b768ff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 18:55:16.8139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5217e0e7-539d-4563-b1bf-7c6dcf074f91
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6MtKoCb5IETyqpnJ8gdDFYwLg3rcSdY44XgW73cng0P1i09WRLqkbLM+oPpWKLIJFOgywyu0TET8bXgeAJ5VCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6414
X-OriginatorOrg: utah.edu
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
Cc: "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Good day,=0A=
=0A=
Dear Maintainers,=0A=
=0A=
I found the following bug:=0A=
=0A=
Kernel branch: 6.3.0-next-20230426=0A=
=0A=
Kernel config:=A0https://drive.google.com/file/d/1KU1ivdc6axWGXqmaODg5wYNJZ=
4v7p75j/view?usp=3Dsharing=0A=
=0A=
C reproducer:=A0https://drive.google.com/file/d/14qxiXna1l9BLxDH2Ozo6oebnhj=
bNi06e/view?usp=3Dsharing=0A=
=A0=0A=
=0A=
loop4: detected capacity change from 0 to 16=0A=
erofs: (device loop4): EXPERIMENTAL compressed fragments feature in use. Us=
e at your own risk!=0A=
erofs: (device loop4): EXPERIMENTAL global deduplication feature in use. Us=
e at your own risk!=0A=
general protection fault, probably for non-canonical address 0xdffffc000000=
0019: 0000 [#1] PREEMPT SMP KASAN=0A=
KASAN: null-ptr-deref in range [0x00000000000000c8-0x00000000000000cf]=0A=
CPU: 6 PID: 14033 Comm: syz-executor.4 Not tainted 6.3.0-next-20230426 #1=
=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:erofs_bread+0x56/0x6d0 fs/erofs/data.c:38=0A=
Code: 48 c1 ea 03 80 3c 02 00 0f 85 17 06 00 00 48 b8 00 00 00 00 00 fc ff =
df 4c 8b 23 49 8d bc 24 ca 00 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 8=
9 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 84 05 00 00=0A=
RSP: 0018:ffffc90003f9f980 EFLAGS: 00010212=0A=
RAX: dffffc0000000000 RBX: ffffc90003f9faf8 RCX: ffffc9001350c000=0A=
RDX: 0000000000000019 RSI: ffffffff83b7198f RDI: 00000000000000ca=0A=
RBP: 0000000000000000 R08: 0000000000000001 R09: 000000000000003f=0A=
R10: 000000000000000c R11: 000000000008c001 R12: 0000000000000000=0A=
R13: 0000000000000001 R14: ffff888079bfa000 R15: ffff888079bfa000=0A=
FS:=A0=A000007f5338e33700(0000) GS:ffff888119f00000(0000) knlGS:00000000000=
00000=0A=
CS:=A0=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007f5337c61c40 CR3: 0000000045e57000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
=A0<TASK>=0A=
=A0erofs_read_metadata+0xbb/0x490 fs/erofs/super.c:137=0A=
=A0erofs_xattr_prefixes_init+0x3b1/0x590 fs/erofs/xattr.c:684=0A=
=A0erofs_fc_fill_super+0x1732/0x2a70 fs/erofs/super.c:825=0A=
=A0get_tree_bdev+0x44a/0x770 fs/super.c:1303=0A=
=A0vfs_get_tree+0x8d/0x350 fs/super.c:1510=0A=
=A0do_new_mount fs/namespace.c:3039 [inline]=0A=
=A0path_mount+0x675/0x1e30 fs/namespace.c:3369=0A=
=A0do_mount fs/namespace.c:3382 [inline]=0A=
=A0__do_sys_mount fs/namespace.c:3591 [inline]=0A=
=A0__se_sys_mount fs/namespace.c:3568 [inline]=0A=
=A0__x64_sys_mount+0x283/0x300 fs/namespace.c:3568=0A=
=A0do_syscall_x64 arch/x86/entry/common.c:50 [inline]=0A=
=A0do_syscall_64+0x39/0x80 arch/x86/entry/common.c:80=0A=
=A0entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
RIP: 0033:0x7f5337c9176e=0A=
Code: 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 =
00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48=0A=
RSP: 002b:00007f5338e32a08 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5=0A=
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f5337c9176e=0A=
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f5338e32a60=0A=
RBP: 00007f5338e32aa0 R08: 00007f5338e32aa0 R09: 0000000020000000=0A=
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000=0A=
R13: 0000000020000100 R14: 00007f5338e32a60 R15: 00000000200108a0=0A=
=A0</TASK>=0A=
Modules linked in:=0A=
---[ end trace 0000000000000000 ]---=0A=
RIP: 0010:erofs_bread+0x56/0x6d0 fs/erofs/data.c:38=0A=
Code: 48 c1 ea 03 80 3c 02 00 0f 85 17 06 00 00 48 b8 00 00 00 00 00 fc ff =
df 4c 8b 23 49 8d bc 24 ca 00 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 8=
9 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 84 05 00 00=0A=
RSP: 0018:ffffc90003f9f980 EFLAGS: 00010212=0A=
RAX: dffffc0000000000 RBX: ffffc90003f9faf8 RCX: ffffc9001350c000=0A=
RDX: 0000000000000019 RSI: ffffffff83b7198f RDI: 00000000000000ca=0A=
RBP: 0000000000000000 R08: 0000000000000001 R09: 000000000000003f=0A=
R10: 000000000000000c R11: 000000000008c001 R12: 0000000000000000=0A=
R13: 0000000000000001 R14: ffff888079bfa000 R15: ffff888079bfa000=0A=
FS:=A0=A000007f5338e33700(0000) GS:ffff888119f00000(0000) knlGS:00000000000=
00000=0A=
CS:=A0=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007f5337c61c40 CR3: 0000000045e57000 CR4: 0000000000350ee0=0A=
----------------=0A=
Code disassembly (best guess):=0A=
=A0=A0=A00:=A0=A0=A048 c1 ea 03=A0=A0 =A0 =A0 =A0 =A0 =A0=A0shr=A0 =A0=A0$0=
x3,%rdx=0A=
=A0=A0=A04:=A0=A0=A080 3c 02 00=A0=A0 =A0 =A0 =A0 =A0 =A0=A0cmpb=A0=A0=A0$0=
x0,(%rdx,%rax,1)=0A=
=A0=A0=A08:=A0=A0=A00f 85 17 06 00 00=A0=A0 =A0 =A0=A0jne=A0 =A0=A00x625=0A=
=A0=A0=A0e:=A0=A0=A048 b8 00 00 00 00 00=A0 =A0=A0movabs $0xdffffc000000000=
0,%rax=0A=
=A0=A015:=A0=A0=A0fc ff df=0A=
=A0=A018:=A0=A0=A04c 8b 23=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0mov=A0 =A0=A0(%=
rbx),%r12=0A=
=A0=A01b:=A0=A0=A049 8d bc 24 ca 00 00=A0 =A0=A0lea=A0 =A0=A00xca(%r12),%rd=
i=0A=
=A0=A022:=A0=A0=A000=0A=
=A0=A023:=A0=A0=A048 89 fa=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0mov=A0 =A0=A0%r=
di,%rdx=0A=
=A0=A026:=A0=A0=A048 c1 ea 03=A0=A0 =A0 =A0 =A0 =A0 =A0=A0shr=A0 =A0=A0$0x3=
,%rdx=0A=
* 2a:=A0=A0=A00f b6 04 02=A0=A0 =A0 =A0 =A0 =A0 =A0=A0movzbl (%rdx,%rax,1),=
%eax <-- trapping instruction=0A=
=A0=A02e:=A0=A0=A048 89 fa=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0mov=A0 =A0=A0%r=
di,%rdx=0A=
=A0=A031:=A0=A0=A083 e2 07=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0and=A0 =A0=A0$0=
x7,%edx=0A=
=A0=A034:=A0=A0=A038 d0=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0cmp=A0 =A0=
=A0%dl,%al=0A=
=A0=A036:=A0=A0=A07f 08=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0jg=A0=A0 =
=A0=A00x40=0A=
=A0=A038:=A0=A0=A084 c0=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0test=A0=A0=
=A0%al,%al=0A=
=A0=A03a:=A0=A0=A00f 85 84 05 00 00=A0=A0 =A0 =A0=A0jne=A0 =A0=A00x5c4=0A=
=0A=
Thank you very much!=0A=
=0A=
=0A=
Best Regards,=0A=
=0A=
                            Khagan Karimov (He/His/Him)=A0=0A=
=0A=
                            Ph.D. student | Security Researcher =A0 =A0 =A0=
 =A0 =A0 =A0 =A0=A0=0A=
      =0A=
                            Kahlert School of Computing, The University of =
Utah=0A=
                            =0A=
=0A=
                            =0A=
                                =0A=
                     =0A=
