Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5854874D1C0
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 11:37:30 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=SlSkR8MA;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QzzS81ZvHz3c4Z
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 19:37:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=SlSkR8MA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feab::722; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20722.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::722])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QzzPP5L66z3cjW
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Jul 2023 19:35:03 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyVh81jlMqcB3h5ssWRlC9xxcRxInGsKOfCMnhQH/cDQfp4AiDPGWd3ao/kXM2/U451DSXuZUkSSUOpL9U3ZQIojEBhT+QdMTywvwi0NVGC8XxKM8Cj9hbMdhs8x0BVUPzEIfWxvXB1YxdULylZpCGbaEwG5fwWxtuAiickmXfnFvCGV5vszCj3CuWzcG7hw6hHVooFZASytociR5imiEx1yPJwfF2Da1HBhRgpBcvZ14//0GInx0Xl1HSwBmpttXAOaAeV0ZeXjbc8xiW7bgw7bM5w46jHsCaQYJtsZZ5vqBcB0OfX6i9wZijMQDmBtP0vynOyEmDrZOlZNg1tvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=496Dj5/E1jMpeKE45lzU1PyYU9YNAU9MIG4JLkeNYIs=;
 b=bXjdcF1kjJFe+YQzNhmvbprpR5hVqx03D+zpAmt9BhsUWGTvBky9+QhGK/eAHkOk0VLOICP92OFcCp4IfVVaJ+Vmwl0aG45Q/8gISa1f7CuGqP/f//F3VeX3zeVEHB6m83CEL2fBdaMZXcjbZZHh000S3Sfo/vL3fAXkhQ3GKCd2C1qtTWUyZJfBNf6vAiSXAYkVC7uLxbkwDc5mWC2BZ+wr0qwdkNB0NUmmcPN7On1E0ZnF6m4TCDkFb5apDoKU503uN2+RSyyc48G4UbAMb1ag0pq0SgdUAFgf2ZjL074zi6x0DUn6/vvGdOLs8IwM53ZrY3Jk17cSakdRGMQvew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=496Dj5/E1jMpeKE45lzU1PyYU9YNAU9MIG4JLkeNYIs=;
 b=SlSkR8MAIrcNPaKfDQ7NaDsdG3RZ1qETljfunrXAGnpp8f7PkExLKkbUw9uPEh6fw0Xj09hEZlnC/bDkZfgE1Ul9nXOr5P3DdG194AwqVVGDEY9viQeN3rkMcPKhqln+IGvE1ulS6Yr//e0cDt5rQj+YogMdn+MBfpe1xMY7RMqVTBYL60QMh7PASGUzls6/aqUlFstRKej7Alz8pW/0dtC6tVh/f4uiJ3YtGC7EbNloEvRmo+DGWuTpwPnR5tvuuvtKtRntDkSn8jmNpqXfpDLYPZPXQrgH2r3cdakUYF4Y+JZ7u366Wfyam3ecoT1Vo4ULD0GPesPk5yh6X+vh5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3338.apcprd06.prod.outlook.com (2603:1096:4:97::23) by
 PUZPR06MB5555.apcprd06.prod.outlook.com (2603:1096:301:eb::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Mon, 10 Jul 2023 09:34:40 +0000
Received: from SG2PR06MB3338.apcprd06.prod.outlook.com
 ([fe80::a05b:2f8b:fba5:50fb]) by SG2PR06MB3338.apcprd06.prod.outlook.com
 ([fe80::a05b:2f8b:fba5:50fb%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 09:34:40 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: xiang@kernel.org
Subject: [PATCH] erofs: fix to avoid infinite loop in z_erofs_do_read_page() when read page beyond EOF
Date: Mon, 10 Jul 2023 17:34:10 +0800
Message-Id: <20230710093410.44071-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To SG2PR06MB3338.apcprd06.prod.outlook.com
 (2603:1096:4:97::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3338:EE_|PUZPR06MB5555:EE_
X-MS-Office365-Filtering-Correlation-Id: 36c68bd9-a5fc-4f74-16cb-08db8128e298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	5pQ7VMhOuE5sXa2LJsEa/uIqkMojpEDBOqSQA+/1n5jSibQs7MleI8+dDfFxAeKRwQKYefsaOH+tIrwI8Nady05oF4zRGOlKSkPATTYOQSNVWrVuTCI1Yz+j++JfjKn5o7w33cChnHu1s7S+3e2sg3mc7QtAqHXP6pOzlGHJFFl7Zc/Qo5HVqHjTiidp0gJnNpGIHCdbRMevbDtzdnTis8cuaKelVEV2meJShCP0TCwa7BVm+qROtyNnOAPMPwcR7dpcQhG+VUyVG6EjgwmgM+RNXKpbIhx/PzuLXjNjRcCRLI5arjAUzFplI+V8TrXQcquAvCjGCTdzlLYh9NTcUZ2LUoqI410cJFRm5EImfAKWx3YqcxpMjlt295Mffyw0AyxU6eQ3wcx9C98PlbDXvSzj8mrXswCo70edBAHUmxzjGDS6xslZ9MzBcnO2idD6f6HFsydmg0xJ9MgQB7F5/7VazJvfZHRxpjXIGdaviIwz+YteppqGgglEEAcuDJ6/bxbTl8e4KpVVyw3fKRFhrUeGWm1un80PJiXNfx6PquL8P3prbKA1m/H2HC8ae69b8po6myICHXmpmdgT0slxFWW1NraBRsik93kSLs+Gk8yX7FB20atUlhMhGxhH4yZQ
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3338.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199021)(36756003)(86362001)(38100700002)(38350700002)(478600001)(6666004)(52116002)(6486002)(6512007)(8676002)(8936002)(5660300002)(2906002)(316002)(6916009)(4326008)(66946007)(66556008)(66476007)(41300700001)(2616005)(26005)(1076003)(107886003)(6506007)(186003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?M9l8xoCLRRk+JGPBVtt5Y5Qa5PQFjYEmPf23Gv26L/C6IW474yPPnSmILkOb?=
 =?us-ascii?Q?LnVvG/476oIhIC7TRYes1ylvb7KUy2r6lUVLvd5rvGaxvS1RMmiAjtre76PH?=
 =?us-ascii?Q?xq4eiNCbNdNz0GFYnFbYK1dVvgQzcwaMLzcmDwXxdReRBlr+dCYeceQYP0t9?=
 =?us-ascii?Q?iW4iVTFTmF61llJ/vqjQDmhYB1tedyC+HhDhYt/XoZNvDMQ8t+f51jkOGKXz?=
 =?us-ascii?Q?tAZMB4bwmzAu1by3D3NMXnztRm1hYOQikP7U+vvRlwi133M1altig19JXwUO?=
 =?us-ascii?Q?I4nrd/ZSS7GPhdfqHi2OVw69uvH60UAzAK4cGZpBUuPHl0xm5ebU/tIBVUan?=
 =?us-ascii?Q?5a4tnXraDURh5qJeCXJWvBnfBeeFUhgxz+9FH+BxGNMwAd/bEp4i6OIPWRSv?=
 =?us-ascii?Q?2w/2Y4iimGqpcijLFhIgTDGApwcmoh+EiEUbPcVjoB3V69965bnSGlNvJ8HO?=
 =?us-ascii?Q?k9dPZBFIrkfhPrMM6Z1fNlUOPwQz84hZQHKe8Ixk6cFfds9BZU24ayuPpi/h?=
 =?us-ascii?Q?6D0ybzbuI7adG2oZs7qgf4Yyb3sLkIPqcXC+FKEpE66PIOOsGQYlVYrMEKSN?=
 =?us-ascii?Q?vCtAMMjkylB2wGV6QyQrh72+IRMUHURyDiY4GDwMBvY6JPd/Kc4lPDxczCl4?=
 =?us-ascii?Q?6iUI3IEwmKuLl5uBkQsiC1zJmCcVEgD38QERc67k7wedWVpk5akcKBm7u9hU?=
 =?us-ascii?Q?0nhNDw5OZgRhWGxyX32RUK6kvVhzpspacDRd3tNVdbrdmxwNwuRobMH2Zj/V?=
 =?us-ascii?Q?05fgNyypW1wQcUI4IBvFc8AuhxswCo11gkJzl8+/HwscZ4BTxDcJ/DnHcfC4?=
 =?us-ascii?Q?Tjq0/tOaS3rJI69w7NMjR0+35Lj8SMAt6FG+03kpvh5rEjjYX3/317FtfibM?=
 =?us-ascii?Q?eMRnyB5ktayyckbnU+heemdN9SXCeoSBIwutcnROt/OOPnwf3Mxv7P9LLdwh?=
 =?us-ascii?Q?vnSiBcUtXTdUVPU0oEnCTtxfPdbX2xYE5cLvGcBVLnAHyiCC00LA0UifRK33?=
 =?us-ascii?Q?OujtjNAhU3NPkTz7KIRQLqHydBqs5fk/kTM+ne2qs8rCXXu09+na7DTtXro8?=
 =?us-ascii?Q?l8a6QPbQkN/uzQ6FGYL8MK72+rAgXi8A0YE/u/ykDvi+q+MORmaQsSJoeFUB?=
 =?us-ascii?Q?vjTQvEE+kSgwxHyTthmrGvxvAHxh6ppHY5WKfmGtOTKE76U2WCb1pmvwkYqZ?=
 =?us-ascii?Q?4BCmc51S21fKfB1B5Fmbco3WIh8e/+VrBPcv6lo4xE7y0Sq4A06pJo6I60a8?=
 =?us-ascii?Q?u5uiEowc6sQbEWwY6jj+LLnE8hc5qmzA7P6pDq5XRA8rHfrhc3JabTfhd2rL?=
 =?us-ascii?Q?dcljoea0i5J+Tnd03wi4eFywggd5hcMgKD1c50vCSXmL20P1lccvzuNL8HsC?=
 =?us-ascii?Q?H4H0uCqM/bWLg6YXwjBCdOez4s5S36Nr0ZFvPy5VQdrg8bwqAxupedsM3R33?=
 =?us-ascii?Q?I9GOrau12clUySanU4Cy4N/TY5PHW7aTWxQpQbUgCKzcuabsq4pEPPKMGj7+?=
 =?us-ascii?Q?KwAKTCWsepKdb6mdokPq5SSPrKrzAUgvgWUgH8FyeN0hg9K2l+0iWwMWFXLa?=
 =?us-ascii?Q?KOg4rNfGy/mA5mvGq91G9WJm9z9/DfAXAlxQ16do?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c68bd9-a5fc-4f74-16cb-08db8128e298
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3338.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:34:40.4576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvQDhNVIzcflYrnkSJlsVA2SzFAlCQNIvGh7GXmxRbOTBVO2riTqBCjurxVbO+z8yWJ3gcpog4uKft5J57M7hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5555
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
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

z_erofs_do_read_page() may loop infinitely due to the inappropriate
truncation in the below statement. Since the offset is 64 bits and min_t()
truncates the result to 32 bits. The solution is to replace unsigned int
with a 64-bit type, such as erofs_off_t.
    cur = end - min_t(unsigned int, offset + end - map->m_la, end);

    - For example:
        - offset = 0x400160000
        - end = 0x370
        - map->m_la = 0x160370
        - offset + end - map->m_la = 0x400000000
        - offset + end - map->m_la = 0x00000000 (truncated as unsigned int)
    - Expected result:
        - cur = 0
    - Actual result:
        - cur = 0x370

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 fs/erofs/zdata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index d9a0763f4595..b69d89a11dd0 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1035,7 +1035,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	 */
 	tight &= (fe->mode > Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE);
 
-	cur = end - min_t(unsigned int, offset + end - map->m_la, end);
+	cur = end - min_t(erofs_off_t, offset + end - map->m_la, end);
 	if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 		zero_user_segment(page, cur, end);
 		goto next_part;
-- 
2.25.1

