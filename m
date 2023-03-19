Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2166C001D
	for <lists+linux-erofs@lfdr.de>; Sun, 19 Mar 2023 09:42:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PfWZp5jcwz3cDp
	for <lists+linux-erofs@lfdr.de>; Sun, 19 Mar 2023 19:42:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=qBqmJJTz;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:704b::722; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=frank.li@vivo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=qBqmJJTz;
	dkim-atps=neutral
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20722.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::722])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PfWZg2Hmyz306l
	for <linux-erofs@lists.ozlabs.org>; Sun, 19 Mar 2023 19:42:17 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnyxAq2WupcXNIRMx+xbO6jBYXoSH6RlxYWjc2Zg1D1HGPAKdvF2etjfEqYc5NS2qAwP/BfHiT9X6C/7IKn/Hoz9CreX+V0zzz3/CzPSIZcwDuqhF5pPEr554sTXHRv0dNfJ3FcSdj4xYWx/GkhyGDWcsHOPlMrcbdktu57wazum9kJNiqXPzV4M352w9xnDReKvbjrxYbBOUVjOsncpqohHssjUaKVQUeLSnahCO5HvDmaGRh+gpsMu1kHN/EOfXEKJAvylZAtnt811eZF/U0MnuBlzR47R43EbIZ/HH8McxlpGUy+2FDUB/PEW57EK+lZ7Ly/enPruIJBwnkOPiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhVLGznBksksos1LREE3is/hDxk3CkKEditIjWVYL0I=;
 b=DhBoZEiDk4Zva/KPdXOZ+Ee+3sAAd/by7Sg9gDaBpO5PlPPcnm5Wnnajn+kkmgvJuptkM5f0LhXGXgUhA4ApK+9A71bUIWid0vqEm7yZ89jhjZkphZ20JiQoODIPp71IHN3yA4AsnPQY3Jba6pyjFwpmO7iumMEAi6OlMJYpg8pamFxYK4pJVr7zbxpozOuZLZOivicYVUoyUjm3IEYXKIQFvUcuPnn/QJ+p4Vt0t42UiptsoCKTv2IrEXwzxXBzjzsdB8UtiQ/PHTRcb5QKKXW/WISQi7FGt2pAdCAtW22Sw8GKPDM+wZnKdTpyggpp2NI8djtxH5d2s/QdH9FnIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhVLGznBksksos1LREE3is/hDxk3CkKEditIjWVYL0I=;
 b=qBqmJJTzUQIvKbDOdl3xhM66cbEryL8Leo0uULuWJiywJxp96sHxIPAx/PWHU1jlLPL8UP0RV8ET4SwCu0DWdsmSQiEa8uaRdsWil+d0CEUO9WtYisDX0hzSkGonV0Fd6W8HmY6whk1bpkCWbJFcqmI817mUEMoisAxxB9Z/eCJVcziFUK1IhiiIXeJLHuzh3T3RI1pc8RxD1NTOJ3PQlNidSmMp14cojT1X+wjDMys80RuweAsR2JZnU/oz4ySEum/mcMndAuPTRQKcyv5ryuY4xQEdDJ1Kba4b9ecBu7c+O9JXvFxHh6sIs+U7jdBsszX08WrEY5QiTEhkr6USmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5350.apcprd06.prod.outlook.com (2603:1096:101:6a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 08:41:53 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 08:41:53 +0000
From: Yangtao Li <frank.li@vivo.com>
To: Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH v2 03/10] erofs: convert to kobject_del_and_put()
Date: Sun, 19 Mar 2023 16:41:26 +0800
Message-Id: <20230319084134.11804-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230319084134.11804-1-frank.li@vivo.com>
References: <20230319084134.11804-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5350:EE_
X-MS-Office365-Filtering-Correlation-Id: 57fcd48f-bf40-4ad8-98c9-08db2855ca31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	yflELsa2m3GZA3i/uz9G9zrQPBTWdaEL3D24iGjcECpxZC5kKC7SYHCo8dqD2pcre2i8obkEtzRQiDIvdXUvQQNRodyRHmWxvWnFYZzDwNZIRuEA71/hqwk504D3MVL+ZneSDYJQTsv9J8yvyaXcDN2+JVo9MzGO4u669Gxe+NSCuLhrGO7BFjl+2g79TW3s1JP3o7TFLU/uiVfRMa23OgIln7WjQfUrZRDzVT+c99NMLekeo2wPF1HmycO77oIF0ob/1Za1+QJZeTsWRs/ZuUeCrJSP/wb50i3cIHjp+3b5P48d2Tm86NWxx/iGQ7dBbvpVy+H+adln+UTZol101m1gefOp9Q0VQDTxmHng9Hq4cqGbdWLmKKhrCKUucnbepaRq4RT7+Z+SMwvxvmUet+mG1s0LeH5djtGPG5DeHmW0PIBl9/111SwpoPpQZbDljIGCw4t9CNyk9aGY5+hzrbA6/xKb4Qrd5/FFuESJCBUVqwUHLwoX/XfjI1zsMZPg3a6V8Zx7eUG1TXUmxJIJIAkwxl0fql1mnW2kIhXk5QyKOeEF2NKRncqPepqDe9QkhgFvUYKNhJzVDVoojzIIfK/NGFr6RuG0pq6Bw/3kiRKB3ufmwaAfGypUeaEirmFdK1OF0NhEkNdRvZHIzdJsbLjMM7WCW9t/hx/dY5DQjGrGyQPGHzrjXbOKMHKCcXZHKNrwGuOPAuyGqOY1ryrikQ==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199018)(86362001)(36756003)(52116002)(83380400001)(316002)(8676002)(4326008)(66476007)(66946007)(66556008)(110136005)(478600001)(186003)(26005)(1076003)(6512007)(6506007)(2616005)(6486002)(6666004)(38100700002)(38350700002)(8936002)(4744005)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?evVpKhuWuJQXgwny5SjqZMRl8vbHamMLTHEY+O9kPfJLl/B/dPbSbTgzMu2h?=
 =?us-ascii?Q?Hu8XzQUcVQ9zyeuLL1QERuy7zjZ8U6y3bNl8uvbECP9FRsY/S0K0L8cBI7u8?=
 =?us-ascii?Q?9LMdurUSorqPyl1zuv2UqhwX6JdBdNtcIgWvu3cbWx8CotL4cv0yV2fQ4+Fs?=
 =?us-ascii?Q?YDtsauRJtJ11qdBcXrOwqbupMYy6q6QCvCtI83VTh2mP/0ShT84SdehZJ0A4?=
 =?us-ascii?Q?UHNxkpKgYEybKlNMWxR4uWRzGEsTvNMI/kOKAtL9pwIvUxs5uX8UM/I7+eT0?=
 =?us-ascii?Q?SjtZNE3DbSKDbpv/LPtgnwQht+VxLgCRULw/zWqLODOklCE0OlpeKssuQP20?=
 =?us-ascii?Q?xZj/M5MYSgSPNasbWyjaoZbu67cgucG6CrblUkfdrkyhu5SxRFOGh845NYjH?=
 =?us-ascii?Q?7Yoldj9bTAMvdryGlHjQ6LbgpEUzppjrpqLsc+s41xzjJ4Tr2NorD9lTbMxx?=
 =?us-ascii?Q?ujQQLjHRSUcchVKTGpIC3NlR5Qj0i6XjTuZkMI6zJ9+IG/6q/3fWi7bZvRUQ?=
 =?us-ascii?Q?Zss5+tc5MpUGxJzH3k9ZYZDpsLj9lmq9Cul54BZfO6LwSJ9kFT1bdrH4TZZR?=
 =?us-ascii?Q?HksQ+3RaY7m6AAb3Q20CyVbwktuOFdHnKCfsu2xEpIaazsGpV9bv3srqxt4s?=
 =?us-ascii?Q?wsdQmtmydUO8oUfj/81LBmDeJtZrly+w9loqxY2xtj3re63H17Em4EDYwAD+?=
 =?us-ascii?Q?/j+UQe1JU8iM40CxJ0NWaRaTI/ZN6e0ZijA5sqwmxOnEKuNdyvW1hBxoW98E?=
 =?us-ascii?Q?gC8RA8yrtSqVFEOugI30cqE+bli2rE4Y7n+hv8CrC1i+GkIsITZsBh00VQa1?=
 =?us-ascii?Q?MWFDn5CManIufp7rEiewVbsQqahtZ7Aw8IJ2tmwxMyL+cMuCP6XjGeum6exP?=
 =?us-ascii?Q?6XbatPnLwRUzzUQXLXaTvvCF7JjxzN8mhEw7emyMO7y1JTSVSFy0Z786Gxze?=
 =?us-ascii?Q?gDjAdoywBVr6g9WGvoHkKXCV2yCR3PVumd3c+Q9vPIzi7hIXjp4wcPSrgOFg?=
 =?us-ascii?Q?GH0OwM65lQmf7w2+yV0371B8oqS9u5YS40z6OqdHuERuZ/yyKYpkCbsNhc6W?=
 =?us-ascii?Q?/+47iOhS+0+khuchfdQ6kVLHD1jJ459HuJ3dO2Y7S9VeD5eQpLFQK6sfQTFB?=
 =?us-ascii?Q?++M+QJGg0K3D27/5KRhBT4NZdyaFVzxx00D/e6tr0pMmS9PGr9cJXczDrLWB?=
 =?us-ascii?Q?BgKAO1y7bVtQDzEus8Tfr5dC+iBaKtgV3a39G2oNcMf6j9pd2u3qgDBCGXEM?=
 =?us-ascii?Q?9HwUNFsd35H2ZyDC0jnzqyRhQBCWRv14FUu8duo8phs0PQJxwoyX29VVv0vk?=
 =?us-ascii?Q?C7we5CsLlJcI6bHAxztcSW2/Vz0yWkAsia1KvGOoYF19v6ArxXyTubtyKfAw?=
 =?us-ascii?Q?Z7wxL5cMTdzxMQBb1t3+Ridg4XmORo4TfZfsPzGfmF9LZijIB8J9tmeW1wmm?=
 =?us-ascii?Q?uDnCy+VRRMLtfGsgmfRqIGBvZmvXolOeOY1rGFL+qgI1ty4oQ6LW6U5sNJhj?=
 =?us-ascii?Q?8h7JJVhBxtQr8gPbTL4UsgPtyIthirvVeLgu+79HSGT67UY9CJei0haLcIZB?=
 =?us-ascii?Q?Aqe9KTTa8f/NVYBu0kW3CUbzTbRL6jWw814knAfe?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fcd48f-bf40-4ad8-98c9-08db2855ca31
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 08:41:53.4198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kEDnVVP1cYnDK1IbzVhWFEksguEsSAta/0/QLfDITfCFcgAIVWuj2RX8YypDbKH3GX4iYxgExysByZbUDokRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5350
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use kobject_del_and_put() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/erofs/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index 435e515c0792..9ed7d6552155 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -241,8 +241,7 @@ void erofs_unregister_sysfs(struct super_block *sb)
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
 	if (sbi->s_kobj.state_in_sysfs) {
-		kobject_del(&sbi->s_kobj);
-		kobject_put(&sbi->s_kobj);
+		kobject_del_and_put(&sbi->s_kobj);
 		wait_for_completion(&sbi->s_kobj_unregister);
 	}
 }
-- 
2.35.1

