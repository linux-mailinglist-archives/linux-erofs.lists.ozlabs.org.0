Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0D033E7E7
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Mar 2021 04:55:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F0bsK6wRyz303T
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Mar 2021 14:55:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1615953318;
	bh=7O3X0mfB8+9z6WVHVDx1MQcNvPr5AnOSfe+SnbMsMG8=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=P5ZPXATYPY2Sc+wcrT7WsbiOFZbbkU4mJ56j8Udo83+S1wHkRpR8MMLurNKPT+6rg
	 csT5fAWIsJVJUOjfxtGQ9tFMW+N281YBpYG/a5DXXNMziLa/y+hmxjk1Pn5slImXyg
	 0OV+/XPIAC+DD3WgaYdwWmzndy2yjnphyTMUldeZDC1OK5SH3pOhXYTZp0h+cW4UVr
	 V+n6Bek1YlOHib3jC0YWDWu+qKsuSmFYXnqBqVe5UeVnwQ/BArZ4NEuDHPJHOtGZgi
	 H7rCLBxiakbldObQNx6NpNaWbWhygLn37iiMh7wurClVfI5ll2jwpG/JGAkU6fTNWf
	 rhM4f3EDJqchQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.54;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=hU6Z5GVT; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310054.outbound.protection.outlook.com [40.107.131.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F0bsG0kZgz2xZv
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Mar 2021 14:55:14 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmDVoLYXcbd5YiU+k74N1xeQ6W+mKWUUI9LAA2qq2uteMoJLiQUYp0oSd3+GpQacwroWFk6dSdNwIEumQ+cacCGAZsHmaptoUF1+lbbgyeu++I7M/H72PzUdUqTPdosFYEtMl3y2wJIOoo9b+WWmdpYuIVnFEQMCD8nh5DwT/GR4GewKTmUozB3yR+E38sveSiHFBsm4PDCuyIKUt1M1D4gAglr08oxWcywW7ff8pPmyJSYieVtUUAs6jeeQ8dQ4HHC6KTT58lo5fnC3NjjcgGIk/gNCo7m44G4axq/Pa8GoVSMAyN4NLLUqvTbcQtZdVz1k7m3CcLOD+4qQRXInPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7O3X0mfB8+9z6WVHVDx1MQcNvPr5AnOSfe+SnbMsMG8=;
 b=AbfKQyzwSyuu0oBzZ9d80eOhJ6TBg/0YTWk0y+MWwTS1hAkdCT/gzRvys5HsNMh4kbELSWNTUAmePMh1OEynRPWjNXZeNbafYElWdKFsihraWEwpk1Mdow/J+lfXZZ+B7HfFXa1NxZFcv3RH36pU+LSJJjkAOnA4ufGFEzZBenAQG7BlyAShB+df+EdfoCd8N81RFdQaXY076LtWcWEm7u81zICi9GdYgRYMm0lMnWzsvF6W7nstNpBV+ajvkN3nyjS9U6+0i/vVkb4eUpA++LYA6CSathteVP6Pg6+tOdGlnT6EB2bYdXjtt4Qd9Q6p5MLej1obG+2tmS2hmk/PPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2986.apcprd02.prod.outlook.com (2603:1096:4:5e::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31; Wed, 17 Mar 2021 03:55:02 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 03:55:02 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs: use workqueue decompression for atomic contexts
 only
Date: Wed, 17 Mar 2021 11:54:47 +0800
Message-Id: <20210317035448.13921-2-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210317035448.13921-1-huangjianan@oppo.com>
References: <20210317035448.13921-1-huangjianan@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.255.79.104]
X-ClientProxiedBy: HK2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:202:16::16) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.255.79.104) by
 HK2PR02CA0132.apcprd02.prod.outlook.com (2603:1096:202:16::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Wed, 17 Mar 2021 03:55:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a0b0cef-ace7-4c83-8881-08d8e8f87156
X-MS-TrafficTypeDiagnostic: SG2PR02MB2986:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB298620034D833E7CC016C5A4C36A9@SG2PR02MB2986.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xj9lqPyQRyJ61oLaQBa/ezvjITwN6HbfBrYgYXrgRrBulj9+5s2qrM4bLkrl9PZIsNTIouhdsN0F+hd6HvjARO8hl08USjbU+YrLwqfNd12AGjq1Bws3xn851TzwmsvbAseyvK1J+gEiSnPQQ6z4HcTUuQsulq6ocnaa3nb3bjucd3rlns+YPLh4nn2PdSI+q81DGugupbhIGmX+tZBvX7oLNpS1ZKcX1z0CFpKZYN24B8050EH1Ls03GX1fSMOW+plhbhNl0iZijIArpDBfe3v6SfxoKWFRCGcD/yXZNnLUl0ugZ3TtskqPlMRaqx7szalfca64FT1coFejueYYmyh59/nsVrjLtyXxcokbYYfIk7Er6L1mZmzR/TNNIocMrpVgT/OgCEcIOKHGuPeJX4B0vqbOSHv7xJ3P9ED14J+3HU4Xax9uQAsS1Jb+cyVfQFowfavprKuDtiz0F4E5TSBTBgh02E27rnNcVMRDltI5nRHzyDnnFTJAzQ+4rfDzLEGVO2wvCcOeaQ0dTt1Y3SteoX+9Vq3ugSPPuWvbewE6lKnqHv2y7KwtnjD2MidA26cvQXL9OwXIAAyrPEGVmX+v6M8TxW7/bvprFcUnvoQKsnT+X+WR6bp3BW8+g1P8MYYTAzex58NsJVsTamMkUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(478600001)(6506007)(186003)(6512007)(2906002)(6666004)(26005)(956004)(6486002)(83380400001)(8936002)(4326008)(16526019)(1076003)(316002)(66946007)(66476007)(6916009)(69590400012)(36756003)(66556008)(86362001)(5660300002)(8676002)(52116002)(2616005)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ecy69OESSoJHcfRmGrCzf5TgOWYcHCuPr36c0dnj180UlMUj1arNY8e5OIL2?=
 =?us-ascii?Q?XkXz1YrrBDRkJMvBVeIx03vSZCLOQhhKjf5I0Mrsh3DMMY3wu8eoOlxoXjcB?=
 =?us-ascii?Q?qxecq2jzRRf4pTjjdtMIOeKgnT8tEUzSKetf+V+nB5yRoYAg7Bwiof5Ggtmk?=
 =?us-ascii?Q?vL5ucwOblP1UC1lAK7/0Dfy+mE5Dt/702ZzxMz0c5957GnjrrvOR1Aw861tM?=
 =?us-ascii?Q?mEcIJo/ynV4c9GntfLugwIPUdQeKnXiUeJBUT5YDRAvHVRFleWxIUdUfCMEW?=
 =?us-ascii?Q?SKplB8TcunMyfstekadXLTEFJEFPWIubIr/OjYqJmv5rlc/5wBWtk7AD/RGa?=
 =?us-ascii?Q?7+eXpkNHHE7jlSLquDPe9ccSqBHx1LDT3a46WE2n0023gyOFy4gGscn8jTnr?=
 =?us-ascii?Q?raUc0L1wmWSAavpouVLEbjr9ivpM6WBMa54uvXIyQIau4duI5Msvd3A7sQ6z?=
 =?us-ascii?Q?nsju/u8TxyIke7xD7hTISZaZX0w/OmPpITfyqYPoHUzRnQu9ugtDFIdgKnQf?=
 =?us-ascii?Q?+GHPbO8qtKx8JGn4Evt+KqD0qOBdcZiWpyOUzIKFPISehL4UBFySiQietMa5?=
 =?us-ascii?Q?Beg5PN7WZeKYJXD3as60kdDgYnqyfswSsoDsQExNmcvfex6/97MPE5hNIvqN?=
 =?us-ascii?Q?iUW113WplZ3rGNdeKqlkWsFJo2ncQob1eKyzqB6VA93CqZmVwQiewWXEg5ht?=
 =?us-ascii?Q?bqBnQptmtP0xPiXbPe1YNwwoMIKXKUSO8oPfFpruXT/GCkJJCitUNG2RLNev?=
 =?us-ascii?Q?cNLEm5SdoZmDKmnoEBMDMArmPJetu4CTFhqYORTITfb8P4n3ghmGhhefWjcN?=
 =?us-ascii?Q?i7GkVKqsJNJS2Ypib/ZFkQkvxd0XYc945Gp7jgmgintPLmCeUR/h9iNUE/dv?=
 =?us-ascii?Q?D/IYAhxbzrNbRnnPf4hEj01jK3sN5HsJFVMOPoZ6ZwjqK+RskPL0dbVlb+cx?=
 =?us-ascii?Q?lfVdSGGaRS/sasenE5ySskK415GCmuLQhq1QjdscsZU4XRfdQUdmq/kzCVZa?=
 =?us-ascii?Q?ca76YFzNTeIIQJdNczPzgPSpm007fdTzauvq4qH0zQLEEdtcqxC/FXlepmzY?=
 =?us-ascii?Q?os+Tjl9oFgiB1f6YWyBybzrBAMtECJI8Z6kgfPfHd2MUTshC0LDQdg6ccher?=
 =?us-ascii?Q?aCdw1j/m9q5f1Qp6nY1/KnH51T8IRf5ojg1+qpPq6urZxmd8rUuIrHBybFKV?=
 =?us-ascii?Q?eGv/9sIVgmFvXM3invk0wd8znO0uoP0BC8cznphCALIIqTEh5DXtE6Uc6eP9?=
 =?us-ascii?Q?Uwvpp3bF3vNkPeeHX+d64cEPKSMukShhWoyd/u7vU2kpDpZTK+TrLj48wuYC?=
 =?us-ascii?Q?1AfTYvoKLKeIHYx8WYexyyLK?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0b0cef-ace7-4c83-8881-08d8e8f87156
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 03:55:02.5644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpU6nsaWTIdjxl4Iw86SUbtT+2CdLw/s5giTOYHGkY71pbp+QjbnO2wf69OarpUsyte7fnIqcocBbvcaD+WuDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2986
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
From: Huang Jianan via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Huang Jianan <huangjianan@oppo.com>
Cc: linux-kernel@vger.kernel.org, guoweichao@oppo.com, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

z_erofs_decompressqueue_endio may not be executed in the atomic
context, for example, when dm-verity is turned on. In this scenario,
data can be decompressed directly to get rid of additional kworker
scheduling overhead.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
Reviewed-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zdata.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6cb356c4217b..cf2d28582c14 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -706,6 +706,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	goto out;
 }
 
+static void z_erofs_decompressqueue_work(struct work_struct *work);
 static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 				       bool sync, int bios)
 {
@@ -720,8 +721,14 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 		return;
 	}
 
-	if (!atomic_add_return(bios, &io->pending_bios))
+	if (atomic_add_return(bios, &io->pending_bios))
+		return;
+	/* Use workqueue decompression for atomic contexts only */
+	if (in_atomic() || irqs_disabled()) {
 		queue_work(z_erofs_workqueue, &io->u.work);
+		return;
+	}
+	z_erofs_decompressqueue_work(&io->u.work);
 }
 
 static bool z_erofs_page_is_invalidated(struct page *page)
-- 
2.25.1

