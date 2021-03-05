Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEBC32E210
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Mar 2021 07:23:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DsHjS2rcQz2xZq
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Mar 2021 17:23:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1614925388;
	bh=T2GXeD34rY5WDPoWJUbY8rd0SGK0tO+qg0oGbPnlwiE=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=jnpSNt2f/RgLNs2PKQbwiOi+2uHOd9lNX/xpbLcilHVVELCOV9S24kyyreMq76X2z
	 hdIM0iw0ngFVXqODSpGpDxyoIxv5WmDm+xXYXxOUmFumIeYn7ImMWRfUeCdqGbWhwP
	 8Qj/mwDRamboESwbT/6ZUw5gOi9UIg+TyEV+j8EKktPUB+u0jGB6ouIcPiAuu2it14
	 ozo3HDszpBuve5X7X3WrcpvfO6xCcKbe3uOib1W2CqloXWgG4M4yyNWUaJRz7jobct
	 2YqaprGaxFjsvpHQs18Favztu++2UkmuRCuNf5dJVS3RtS8pWQ3Px9W4jIntJZKmr3
	 1vAe99ypzbKfQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.50;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=uNK37mEC; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310050.outbound.protection.outlook.com [40.107.131.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DsHjH2Mxtz2xZT
 for <linux-erofs@lists.ozlabs.org>; Fri,  5 Mar 2021 17:22:48 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hx7WsdlvMtOA/I/lgCAlB+yxFNE7DpJ8yybok6V3pYaOr9v3y7A3zpzHa0l59WA3Ys3A5oY/ZvKpLb1lShAHgstl6yUxWMTlEjTn9/emWIQtt31dQh9Rc2/iAUvetZipBN0hmQDRG3+Lt1F3pJ23gltqbxWMAWGskJDxjvTs0BLabO3Ps8ayiV8kvVeFh3Gpuc+qsJAK1lYwDIDLl2/cns2o8kHVQ+Rwy16P5/o+Eg1oToJORazfkQtX4byE/VEgNq2MPJu38UQ/8Gzer+eq/O59BeHQklwpoDCyCNnv4nxT4vsFnnT4KEvRIiUcaWjlOfDNoNxNVfWLL4JlbbQ1Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2GXeD34rY5WDPoWJUbY8rd0SGK0tO+qg0oGbPnlwiE=;
 b=kpmzLZJiRNIsVAVuJvp33bmEftCh0amDtCYB9dhxNkRhqq47btsiY9dh5A42EhzvhyUUT9VgZOHuz5UmUYoC5SZbLZ+fvn3Ujsedwm5/2nlfgCXUiYL6+JockB6fFNrKlrsjw344vfX7KmUe8HfbkfU31JbAIgWiQkSjhWK4/HrsFlP872IjQU0VLH92IiNofqEWx5TVfUMBOH1RtJ7D98bbaRvpkKWt/q/HFMJg5p7gl5SsrnYJnT6dmn02qIDYZ1CCNbLB8VmGAoydiz/ILwSMlV3/xERmj2tRO0j44vVVIpY0Ydw1oWI4Zi0Rq1D7dn/HoJsOfOJ25wVY2HRIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB4021.apcprd02.prod.outlook.com (2603:1096:4:80::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.20; Fri, 5 Mar 2021 06:22:33 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3890.032; Fri, 5 Mar 2021
 06:22:32 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs: avoid memory allocation failure during rolling
 decompression
Date: Fri,  5 Mar 2021 14:22:18 +0800
Message-Id: <20210305062219.557128-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.255.79.104]
X-ClientProxiedBy: HKAPR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:203:d0::28) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.255.79.104) by
 HKAPR04CA0018.apcprd04.prod.outlook.com (2603:1096:203:d0::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 06:22:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce43fe43-776c-4384-9eee-08d8df9f0f1b
X-MS-TrafficTypeDiagnostic: SG2PR02MB4021:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB40218E7BE41D3F71A861DBB7C3969@SG2PR02MB4021.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SqENOXfi9fm6jBxPb8wJ2Rx0T2uliSedf7YubLGUd5ylJdC99nA3YCUcIyzhoiWQVoLZDd08EalMsWfMDWHr0AVrulyhdHYF339OlnER62r4TrvM/lRbdIo/hmCG6QKnwnwllDw8jJ8AHlIVx9qS0Ar6/lD+6JN7lpAu/N5JXNcorLvVLJJYj17aNg9eJgX+iBl6V3wHkbPxaiw9sPzqT+DcEDKDfP0JigSw+fVMhrMjQ0mljcpGuvmMGxdaMwLSU3gvU/ijXuT15XO9Epap+/USkSegDdxtd2m1slx0b1olSO+ygZJC5t9vOCRCFvTc80/dkoC4PIjFU3eyuFrvD1axu8osPHTJW7t2FIMSAXZDEDljYorFlqlpMVr5+uQJ3yuiPElJkHyVUg6+24gMQ+iXabmYWFhIufBW01X5GFNnxoPDCeKHkvQgOUnMOUK2d4cWJH75GnZNofEvDRKQf+9dQUhHsMA4ZiqteSaFQrYGbkeq9Ehzr8PnovDyrvtOFUcRG8cTSgWVrf0ug+LuN91dbx7JLDYmjtmuLXcpHlXX5OuCSfvsC7+EeDWXeZ8oWlUXkMd8mH8SYso6CG2RX/QQ/9PQX41QtmPFOZ594/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(26005)(6512007)(4744005)(2906002)(86362001)(66476007)(1076003)(69590400012)(316002)(8676002)(2616005)(8936002)(6506007)(956004)(5660300002)(6666004)(186003)(16526019)(66946007)(36756003)(478600001)(6916009)(4326008)(6486002)(66556008)(83380400001)(52116002)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/6QaFiAd2qPiFKxwQbJ0XieoY910o4vRE3yUhvv1yjevgSoB5NSpmF+ADvfY?=
 =?us-ascii?Q?SEO2w2wHUI2OoitIc2Sum8ZtIEQJwy+85iS6gMQS4KSSQPMkyqdXaSdesNNU?=
 =?us-ascii?Q?VDvEDUikgrwdq8prfe5idJtZZ8DlSTSqRNK5CwIPmitTiLvnsgDiMD1O00ws?=
 =?us-ascii?Q?/cqUWxdjzFiUFW1G4NT1fenW/vvXTUFRUb55NDp1PURaN+Yqlvm4WpI439ng?=
 =?us-ascii?Q?SAeQpmOMLh7a6EGJ669LztZjPwFg4Tj0AGihJqsjwD9Nwt1cg6bGllSwHFCs?=
 =?us-ascii?Q?WUN8Hj8cPfWCOQyd78hVoDXMNuSE+4iwrc/uYgOqHtDxah1vAAKI0bHBB1iB?=
 =?us-ascii?Q?34KNGVxMVFohWKppc9vWB0Kq3q6ZMwNWumTXOCOkGx7f/oicvSHcvueTa3Qp?=
 =?us-ascii?Q?4i2817aEhe5oTM4BxpVtD7opz/qZVIg2EoYi9i9CQw3INNZxn3qrfUvaR4vy?=
 =?us-ascii?Q?s/75EvCtgpjealHYIqABoCYNe5FyCXQo7JdlyzWgYbJJRy390iLQFquajnZS?=
 =?us-ascii?Q?/6+Jnh6433P5W4aY7LZ3G8HK3i6Jl+iauPQoXXg84Xg6stpeMWgI0xOONi+j?=
 =?us-ascii?Q?SQnjxTDB4dMwiVbOB9f0JY9f+LWNA1OIxg8Ai1NhKbnEGjIMcGbjEokHnCcY?=
 =?us-ascii?Q?QBuvbFQidvjpfV1eTbZc1ezsOutWT8J7bg+EN+ljT8KXyp91CZmRKHWsXG9p?=
 =?us-ascii?Q?aVoP6K0uqYKNHx071ndeSNOY3QOWtlHoV9jf5TOPaaZ223/fBdTplhrbsA2W?=
 =?us-ascii?Q?au5zGIsvs2AlhF0kuxzczpXOUwUoSR3yb/pSYZAxIs2LpM5rnt8DO9Eq8a3v?=
 =?us-ascii?Q?giIiHvl7N2kW982d0DnpIKax7idLSMeKykDKiWVMdF/s00OVNieHGKMl8Ng0?=
 =?us-ascii?Q?NjnWfBgiTy/HpJczwoTAwIobS0QDkwsn0oMdq4YUhwjx/sfkpi9k2KwxucnZ?=
 =?us-ascii?Q?mS35AT3C4biix+r1VR4Noufcm28MSj1CWWBOk7CXqc7kdqbKCVUEZag99wat?=
 =?us-ascii?Q?hvtoN7ilRIFNeD4IsAg0GBquukI8AyPm1sWmR3HWymnn6jni6sJXTDJbDo2u?=
 =?us-ascii?Q?IjgOSpK3/GClCy49/xX+MHYwSHNrk3BClBnW2vcLm0gZSsuQC8x0KTa+NaEJ?=
 =?us-ascii?Q?FzHYGLPPvCk5hc321F4YcLV3lHSkLJ3c1lRJ5sY8Ic3ynN3UYMFaAr07mVRP?=
 =?us-ascii?Q?8uHmlTlwMTRcjmJk42AgjXmCi6d9nG5m4ysongwdrqNcdjRa2vppZj2NRsSt?=
 =?us-ascii?Q?DxsvrOY2LSCZMPFWEsYeM429CJvPR3DPZn8hMaZBza0fNEUbncINsRTGJsTX?=
 =?us-ascii?Q?o1v223VvmTU7UCaJTjMfwFfU?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce43fe43-776c-4384-9eee-08d8df9f0f1b
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 06:22:32.4384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: megKlWD5KlpkRQYimAurhCH/Pg1cPehBDdJDURyQrJlQ+Ea0HTsUz2X3x/mT3o6C4zGBALoGn13yDc9PtdsyLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4021
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

It should be better to ensure memory allocation during rolling
decompression to avoid io error.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---
 fs/erofs/decompressor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 49347e681a53..fb0fa4e5b9ea 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -86,7 +86,7 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 			victim = availables[--top];
 			get_page(victim);
 		} else {
-			victim = erofs_allocpage(pagepool, GFP_KERNEL);
+			victim = erofs_allocpage(pagepool, GFP_KERNEL | __GFP_NOFAIL);
 			if (!victim)
 				return -ENOMEM;
 			set_page_private(victim, Z_EROFS_SHORTLIVED_PAGE);
-- 
2.25.1

