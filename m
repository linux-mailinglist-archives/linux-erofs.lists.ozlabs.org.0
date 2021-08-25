Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EE73F709E
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Aug 2021 09:45:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GvdLL1pxKz2yfb
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Aug 2021 17:45:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1629877514;
	bh=gsQyKAPC9mYWCLh+1nBQV30dLgmubVCwkoPgjXTtj0Q=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=LbOMojvIDOS8zX/wG0/gJPy8SnO26L4iRmVpT8iYtyD6AvHpmkTiEdbOBBnmeRuDJ
	 Iu8GJgmyf0kYoHWFM/hcb30wfTaIFQb9ezAQQKvOi2aAYGYXiLf17g/jeW+vwHGs2z
	 ARIQ7ALOFuwPLV7b9PCWAfCo1HGU9MO+mvkq/68NSfIa/y3XGzxohAE8emzpbanlCb
	 vRx59NTwFzpJ+jdeByDrmYLP4rX7mCh6Y358/RDvNyJrXSOW4buvYbJ4sz8/hMrI3q
	 TXnUgHke2qoPT2kjnO52Fz8PyxqvzTf8QrzG6ey95xDR1hLJceF6p2FZM4o6gJD5BL
	 Y8cuymHWkGbTg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.43;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=iE0gENJO; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320043.outbound.protection.outlook.com [40.107.132.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GvdLC6vGsz2ynt
 for <linux-erofs@lists.ozlabs.org>; Wed, 25 Aug 2021 17:45:06 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtHtgZj8vZ+2EYqT8AG+ySCPX4erji+3UI5FCMZLZ+FIUM0C/cK4xA4ITGtRUC7fnrfpZO0XAJ13zOBwlbH++V1PNkQP+SmrWNoT36qR12dwRioP52WZo/EzPGJnSnXthBEtv4NiPEHhB/ls0HgaRt0I38bVHai/kbGky3ghlxntNAEWw6cMzExAEawYut4DRSyhkbjNnt9q7FCC8SPhjMPN+zVuaA4weRwLzbQ1T+fmUCg1xNsU1E6jB4oyOFlbHXrnuYTX08fBfxZ6ctePRsHHznNdi0BbpsGEOvoF9i2x1B6fP4afz+KVPbyDDdYPSGZ16iigSOtdOggV7UXQAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsQyKAPC9mYWCLh+1nBQV30dLgmubVCwkoPgjXTtj0Q=;
 b=Fc72Zf7P79t5bKkslZXS+CMz/6eQTtZGpyag1N7ew2VHxK635pVu1kAynjCUHRlA270BkirF7jZJmt2CZZZVSvtbcWkoT9PHtdabG6il6X4Z5xcyoYWk2XmHI+uYoaAF7UyPjEk34dAtKn1MOgdYbjWPQu65YifYQ9qelarfj0+YNkp4+wQavCHkbUu6pFfgdsQBtS/Dnn26BSvQp/TfjXwDWPJGYw7jzLLJsWKQYHPAhZXY7bpQi1JGLeiTSL1UoWQJo8f4jJUQNXNo/JcCey9UJOBHhsrgpvkhZZAy9zIp813BpuCoYtmZQ1nsIaU2czwYsWDnVI8/dk2GhJFfxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2777.apcprd02.prod.outlook.com (2603:1096:4:56::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.22; Wed, 25 Aug 2021 07:44:48 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::98eb:b373:a778:a6a5]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::98eb:b373:a778:a6a5%7]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 07:44:47 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] AOSP: erofs-utils: increase val for WITH_ANDROID option
Date: Wed, 25 Aug 2021 15:44:40 +0800
Message-Id: <20210825074440.22519-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210825033416.19868-1-huangjianan@oppo.com>
References: <20210825033416.19868-1-huangjianan@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0056.apcprd03.prod.outlook.com
 (2603:1096:202:17::26) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from PC80253450.adc.com (58.252.5.73) by
 HK2PR03CA0056.apcprd03.prod.outlook.com (2603:1096:202:17::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.10 via Frontend Transport; Wed, 25 Aug 2021 07:44:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d472717-4043-47f8-786d-08d9679c3675
X-MS-TrafficTypeDiagnostic: SG2PR02MB2777:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB2777EA1249BBD448B4AA5139C3C69@SG2PR02MB2777.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tan5Op+ThHtCZfUStelvyz+1eJaMwtqVPmOYNmVC/esi8YEPN4DqGqFHX6zeNqIF22xGpBcgzEAmCaaXh0xUakGVUZSHiPAjNiDQzHfQLcEpGZqNpybVRopDXLaSzDOdmxWGMlkZllwUi8t2X8zQfrRQgKMBJNYZMqFp7EUWTD+YVCoxvq/qlqEQ2eyeik5hZXWv5MbRIeXbPWNBYQWFdEZJysmr2p9UIXwQwsXW/JkpW/yvOn0BavInzmMoNexI1C0K02iozq4RbL9DMRpP5e5uJRQnrL7P6ecC1ZEaKUFmeZSKZl5fMruKAMy/V4Mj4nAnbFvyE/6TEBvKyOprEOcLy1Jwgbv/rwwhww47c2PkxonTI5cSiU9eFdiR8fLL12bk7muudAwXeKAxl2kj4LoKDZWXaWzUTOoTcG1hWKPMlO8CueqXYGi/mlmgh/DZNPbt4pQF80G1hOujTTAOMA5WSJDZo2wnemHzZpCA+dYIlD+L5EbH2l2EKHN9hZNUzjQMeSdzXA1hCq+TbXZxdfIPNA64k2lzaSJmwH2uDRJXfAnG7FKSHOZ0AU1y3rkGtgELIwto+/TTa3Nk1oUZMBl5hq1U+m2BBoSILZHaxQdQi6XJU4ss9GgkvlSIySH7LZ8haZcxUeNUXNffGJGdYYlEjeDawHKCzaSAoMuL661srRQqke2HPeS+mRctLFEoqCRBWGf59UA8gr0FLW+VA5d2bACoPwkDeQt7fNFSATo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(86362001)(8936002)(38100700002)(36756003)(26005)(66946007)(38350700002)(107886003)(4326008)(66476007)(6666004)(478600001)(186003)(6486002)(8676002)(6512007)(1076003)(6916009)(83380400001)(6506007)(52116002)(5660300002)(956004)(316002)(66556008)(2906002)(2616005)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?23A7iSIUs53+19TPCPuX1YktyHBgXN4SLnvPWbzwNSG844S6+1ioX+mHJcL0?=
 =?us-ascii?Q?gm+VMmVmOMxZt8rOfV+Bw8OcuV7kZWGacr2rks/blEmtjMvhplUajnftgczn?=
 =?us-ascii?Q?rdi1h+zHhK1hltj+8/YP9MYlQccnSyl4a2DxjGQbb/Z6f8Odb1x/DHCj4rzb?=
 =?us-ascii?Q?JfWDuxgq+GFDN5RtKIHqtvMKJ3nQN/R7ZnvG2z+lPSFD3aFIZtK9UxyN4i1L?=
 =?us-ascii?Q?fwa4AEc8lnfmYkQinmnodBqlNBdTwTaMCZLYeQQLtHVXg5cOD2Dm5CMlN5HV?=
 =?us-ascii?Q?f6aoweE47T/gu0OrAWses2PU56M3Noun1A89dC+XJp+gyUyGF8wEZT5ca7Sm?=
 =?us-ascii?Q?iH3ve2OudfBB0TJStuc92ezkgbR+BoSD3f6GYPSxLtJU8sOPalkVXt9K8UGc?=
 =?us-ascii?Q?EgN4g3Ii4dYTIfUITs5p9NTx++R3EzVcOC72eTUaPy/gHqedgZxfeW1QVARt?=
 =?us-ascii?Q?otDX13L8mLSvkBuhvafK5g7R4fNOw3Ebj9t2EmdVlt+3g4NudytXpNm6jTn7?=
 =?us-ascii?Q?SisX6R4Y/su/uW+c/dO8w7NcQgFRBmcuEaViGhxzi1Yu2Y/53xEXi57i7pwe?=
 =?us-ascii?Q?iVDXs8DQoq0tVkD5ZL/OX0HMZuOdTqDMd1e3OgXD2pXutjwYxIucJpBWuzA2?=
 =?us-ascii?Q?x4fnP88p/y3Oyx5KEVKbo4GIgLE+k2ZguWW+c/ynxBSKNGCg1kQ1FNrT464a?=
 =?us-ascii?Q?Ei84zVerxum3B26LFVpUlERp2oi7es1bMYsAu+PuHdwBxZlPMMGOdHToUqz7?=
 =?us-ascii?Q?IOx4pFqC8ALvf1V3MnTtsv1NieL6epCvz1ANPQJPTYk/G1HPrjev8GAq1/ds?=
 =?us-ascii?Q?37qVioLFpkJa+zvh2P9tUKSh3LgAzcy64ZWf6lw+SDdJfIpoThLfVZBd+cf3?=
 =?us-ascii?Q?VrCHoMJRsAXW5smWgDYOLhA0OYPR/NqhE2ZC+PCeWF695t90Ljlh4oIozGnL?=
 =?us-ascii?Q?vgeqhMzAgKeksjVfMQ3GIp4lLmEiJ7gnMp6Af3nUZDfeZMQ45jDW/2m5zIwe?=
 =?us-ascii?Q?bdHJkx13pTWwpliY+s8eRPkRy4OIzyvCJaZpYNA+5mdpAIgnoSmLvayr5ep4?=
 =?us-ascii?Q?RePw2AvEJbqf4cmJsACGdGIZM9qWvR1WQtw4p2IAqt3KmuGPetunFhD2jWeh?=
 =?us-ascii?Q?UDc8oKKsaiQwI4fI8aH+u5ZHct6XWD9qg84xgVOyM9J1j1C5/PqYM3mSCRG3?=
 =?us-ascii?Q?hRswjA1EcCfBjk7ry8BWuYPKCy8cAV1hltzfyac78gSrJ51Qzayflk+Aul4A?=
 =?us-ascii?Q?BtZV0QYOT28H86+V/NE1qnI2WlvooFH57N+1AlDayUqRBKX6V+7Uq0/kpgkq?=
 =?us-ascii?Q?L1LVZIj/nezH4gLW7Qu8oLNT?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d472717-4043-47f8-786d-08d9679c3675
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 07:44:47.7622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LogiLF2G1O9I/8JkB4jqb7jzc0OIICFZzpkbrs2bIOQoHrZu0+HSnylxeJ3OMRJZCi7enj90IiCZmQop7sqR2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2777
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
Cc: yh@oppo.com, kevin.liw@oppo.com, guoweichao@oppo.com, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use larger numbers for AOSP-specific options in case of bump up
generic options to >= 256 in the future.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
changes since v1:
 - use 512 for AOSP-specific options in case of bump up generic options
   to >= 256 in the future. (Gao Xiang)

 mkfs/main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 10fe14d..89f2310 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -45,10 +45,10 @@ static struct option long_options[] = {
 #endif
 	{"max-extent-bytes", required_argument, NULL, 9},
 #ifdef WITH_ANDROID
-	{"mount-point", required_argument, NULL, 10},
-	{"product-out", required_argument, NULL, 11},
-	{"fs-config-file", required_argument, NULL, 12},
-	{"block-list-file", required_argument, NULL, 13},
+	{"mount-point", required_argument, NULL, 512},
+	{"product-out", required_argument, NULL, 513},
+	{"fs-config-file", required_argument, NULL, 514},
+	{"block-list-file", required_argument, NULL, 515},
 #endif
 	{0, 0, 0, 0},
 };
@@ -289,20 +289,20 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			}
 			break;
 #ifdef WITH_ANDROID
-		case 10:
+		case 512:
 			cfg.mount_point = optarg;
 			/* all trailing '/' should be deleted */
 			opt = strlen(cfg.mount_point);
 			if (opt && optarg[opt - 1] == '/')
 				optarg[opt - 1] = '\0';
 			break;
-		case 11:
+		case 513:
 			cfg.target_out_path = optarg;
 			break;
-		case 12:
+		case 514:
 			cfg.fs_config_file = optarg;
 			break;
-		case 13:
+		case 515:
 			cfg.block_list_file = optarg;
 			break;
 #endif
-- 
2.25.1

