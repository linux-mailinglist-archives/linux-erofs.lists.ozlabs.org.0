Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D653732E59D
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Mar 2021 11:03:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DsNc768q1z3cKP
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Mar 2021 21:03:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1614938631;
	bh=pblvAzrrZL7MJ5ZJOYZcxMUhbNf9jVdHxB0pBxDWKgM=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=gybWT6l8k7Jb62nYbrGhc+7gEK/StUt3tKooDSM2dCTEUbg2TWAOd0rVO1THlo8F3
	 Eju93Y6IxGFHID4Zs57f1yZHMVV9SIrlGcRWN0QFUPtalQaW3QsyOchUv9/MpGt7Xh
	 cBSLkV2+wY0Xp5y5a4/spCeXBnrOsh08yjPOlGcLMiGci0PFQozUqWa46dNfKsdAzC
	 vk9L0Oo3yB8/Gg7dbV83+wRze8yJykHPVH13hH/RichGMRB5b9m9cQdHcQlo0B7gZM
	 TM/H5SVL8FK+39O6tbBkhvRJobySxdn+lsrJ9BUlbk/CBcMUtq9K4ORus5u9H70uSU
	 gun5b3FLlKp3A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.79;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=Nl9s9lXY; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320079.outbound.protection.outlook.com [40.107.132.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DsNc36G2Kz30M6
 for <linux-erofs@lists.ozlabs.org>; Fri,  5 Mar 2021 21:03:46 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYN36iBRSXkNGU6GAFKVmE4M/6qaoOUMK76VM+ruX2d6GvvrHKfdZ9nb0uloz/ciHB0B6kXdCE/lL8BpPn+JdiN8uEXNRILyHTQV4EGimFo3Y1/t/8nlJYliV30LQqMTr1BzFxiDSL7l/eZj/RcIQgHk0+DZPXU5BQVjPYVazGk5e8cwRKzzbdRy7jZQb3+PXhum1aNMKNxhyXMwF1yphcsgdUvspO6qW0AgxGgeRPvM8ZkN95bX0Nns1Z+QddNdBoUkSCOfjQzc5AjLjlYbIzn1yJxk0ZFPsM8sL01EQFvrYQ2V4sUEZ7xO8YWPYBEEjziUoQ0950PvmqpwyQGTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pblvAzrrZL7MJ5ZJOYZcxMUhbNf9jVdHxB0pBxDWKgM=;
 b=KNl0kQDQrM4hx+OBj3JDKbFwrzaXcKED1i0MXVirOFy8r624qNd5820pOdkXXf49iqN8vRBYALCTTLOgwhsT/gvg8Lf6w4PAcWFoovqcAqE+MFEJmtvd1mfN8u/2XFnORn7N0LpIeO0yRlOIonp8IwNjWfZ97c6XxIpL91DkDKlV/JhYA19hVNVAbg+kPZDZqaEN6C67DBizay6Xlf7xdpJXUYIbjqTDe71T/urgOhi6ZLmOVIWTBlMa5i15XDDyBOZpUfV2hu/yF3pjBnadi/nxCBL6gI9KCAlD1cp8ej8X4tkVUHtyzTGVL2OH0z0cuOzryEHfpv3Sp2UF1EBXLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: oppo.com; dkim=none (message not signed)
 header.d=none;oppo.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2560.apcprd02.prod.outlook.com (2603:1096:3:23::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Fri, 5 Mar 2021 10:03:39 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3890.032; Fri, 5 Mar 2021
 10:03:39 +0000
To: huangjianan@oppo.com
Subject: [PATCH v5 1/2] erofs: avoid memory allocation failure during rolling
 decompression
Date: Fri,  5 Mar 2021 17:58:39 +0800
Message-Id: <20210305095840.31025-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305062219.557128-1-huangjianan@oppo.com>
References: <20210305062219.557128-1-huangjianan@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK2PR0401CA0019.apcprd04.prod.outlook.com
 (2603:1096:202:2::29) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.72) by
 HK2PR0401CA0019.apcprd04.prod.outlook.com (2603:1096:202:2::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 10:03:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca9ca727-5a27-4e52-7717-08d8dfbdf29c
X-MS-TrafficTypeDiagnostic: SG2PR02MB2560:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB2560B939F7A96CAAB7DDDCADC3969@SG2PR02MB2560.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HX3Nc3gCLGT61AcIVLYadqYfjcc6DFdxQ8PG6dbVKaVu3UJ0xehcGMut1kO3TWUw0oCTMFBhsR/wVECLFsRQOPLhOAx92SBsN0nbVNx+gPi3UoOuTk5uiIwlLPgsTqQ8WBpzhLMLucvoFHG17W6pzyR3y96eb03ir3GD3lp6q1ocuifqyNj9hOOROb75gqMHXp5h9QgqMNudVynTtbBIPKcto+4CBNy/T/ANYevv8KqhJ0pxt4Q0XJoyO4n2pzqUAL7btrT0p03BmV7dlndgVvCVeNIn5YMgKcvcprgF7jrVhYxJHyLT4IprRchn6VeOpuUdnYGSwDr0zmz3CdzEHI2F1ZU9iJf3r12gtZceesSIqdp+oTj40NCKYvKTNaTq8taWTZ3Mqd70ASi/rJ/hQGl1M7rIs8ugABF2zStHoX2tw3Z2LT+wGepb/VhuV2Isw3SyufZJ19JHCV3zgh7QvMqo0SMpdFpUlc0lWRerZT299k0IOOC9ZZMWOJJNiIiltdGK6oSESPIhUr5WTTlAMN/YH1eNR//sG+dwuiMsqmoLdzoYkiaKGxLzHG7qfRoyxzBOIVFn8v5GFYeu/gWzsncGpoMm7GVhX5DLYFoj1bM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(37006003)(2616005)(36756003)(956004)(83380400001)(107886003)(5660300002)(66476007)(8936002)(8676002)(66556008)(16526019)(66946007)(186003)(4326008)(86362001)(4744005)(2906002)(26005)(34206002)(6486002)(52116002)(6512007)(316002)(1076003)(478600001)(6506007)(69590400012)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6ZP0aWwdLNMoJ2OObKIYjJwOVyDlq8wPbEso3pHxoO+D+qBUalzRmEUOEBhQ?=
 =?us-ascii?Q?73Qq1cjtRhTz7I95uyKQprw1T4bNHg/7gGsdpatbqW5117oeRqt2BNUH51CF?=
 =?us-ascii?Q?XNuG0LBuwQUSQflKOSqq/B9ndANoXPm0ZxXnHAqvaLFrI24sTvPeg7ZsHJZO?=
 =?us-ascii?Q?nrIhMA4jx9xfOLMOMjsTx9guy7GNggaugwcRgdj2onMmEr+4j7Coe/wOBAij?=
 =?us-ascii?Q?3gixZJQNCSsqV8jSK2UEVwfC1hRvXr0ahg5TBKiNgi4ciUGSW+BnsUMcvKES?=
 =?us-ascii?Q?iGsB++gRqN9wDqOiRdjqTw0oCKyL9RIOjxuDthDHEzgFu3hEV58QX5Vms3eB?=
 =?us-ascii?Q?qSWCUxDTcoXONsOqbEbhsE7uRDvGsy1TauIdPGwaxO3e/4A4yeBj+vVtzbjd?=
 =?us-ascii?Q?TlRqRTTOqpRQjyYMlF3xR7Oa6LNgzzp1i7vQe679D2eOvePcQOzkUtgVKGd+?=
 =?us-ascii?Q?tSMSctKLeypfSRoweZN1BhsC1kiz5h899CKviLlrwrWCcXh1s6gC3QRuZ4XL?=
 =?us-ascii?Q?BnJpLj7FEqrgYRNKFlhi7YnjGHtHR8wvRmxqj3delplrOIFrIl0Jje6+r5y5?=
 =?us-ascii?Q?7626PUdtlbvRSdDMTa98vJfBzIClsd2SIS97osfPYsj6jGpTVuRgEy9UqtVB?=
 =?us-ascii?Q?InaZkSkHHAAPKcSo4xM4u8rsj0G/OzaHwEHWu6Z31Nw1E2GF8MK0qTpbNzrd?=
 =?us-ascii?Q?zGcWOa1mB+cVWhgBn1ujkxqjkgYLXxV8GoIItQfpbkN7HPZ+Nx59WP9PHYJu?=
 =?us-ascii?Q?uxWHQ1BjgbkSSIS2o1FLktOO2seO6LjamXxcFrGkLIDpdO/K81B34D8Eb537?=
 =?us-ascii?Q?TSfFU1kCyR7VnOq0UbYtZBG9J7KYZm7Fk2k8f66lUXQ9cU2MT8dpAy0mTiw8?=
 =?us-ascii?Q?K4ILbvUBNxyXQtPVpeN0UrhaVdIxwpy/ayKC8jwdZUDXje6i14A/ZC3Fs7o1?=
 =?us-ascii?Q?+hnpXHT8s4Fl3Q48I1tyethBSo+kiq2e5qR01y+/zg3pxugkVRks7k0Ro06D?=
 =?us-ascii?Q?ggjAR2GNUTwx+MJvYd6OY6IaxNcDrFLRIHjn9B/Xt2YWQifdxYNR+KABG6EW?=
 =?us-ascii?Q?yg88ZevHfoYR2Q8pBTf1GGAbIlu5evC7JUslGIHyGnrblWR5XY2Z4X74PPrm?=
 =?us-ascii?Q?Uuz//jnbTRPy7H7yl2xS6osw0wex/QwjMbZlJLpFjkCjHpQ+zLFd2fXxDD7o?=
 =?us-ascii?Q?F8NT+7lP0o4y6sz4L3opgtJr1e896krDS895JPoWwsR0rutmFGoxlbRc5kX4?=
 =?us-ascii?Q?M9CFhhtPegWcvv1IWnuF6Seq9F8dkzCXYOJgwYv2L4usJm/oMXLt5wrFbSgk?=
 =?us-ascii?Q?6fY0rK5yN5HdB75W2xURJvVB?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9ca727-5a27-4e52-7717-08d8dfbdf29c
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 10:03:38.9885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgVFapnA6N/Jw5Y0c4ZxFmJcv+aFl/xro905wl8UPb+7VbVVdPyMX4mIds5XeXiLOYXUnGqxesHODcuVyOLmfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2560
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
Cc: zhangshiming@oppo.com, guoweichao@oppo.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently, err would be treated as io error. Therefore, it'd be
better to ensure memory allocation during rolling decompression
to avoid such io error.

In the long term, we might consider adding another !Uptodate case
for such case.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---
 fs/erofs/decompressor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 1cb1ffd10569..3d276a8aad86 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -73,7 +73,8 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 			victim = availables[--top];
 			get_page(victim);
 		} else {
-			victim = erofs_allocpage(pagepool, GFP_KERNEL);
+			victim = erofs_allocpage(pagepool,
+						 GFP_KERNEL | __GFP_NOFAIL);
 			if (!victim)
 				return -ENOMEM;
 			set_page_private(victim, Z_EROFS_SHORTLIVED_PAGE);
-- 
2.25.1

