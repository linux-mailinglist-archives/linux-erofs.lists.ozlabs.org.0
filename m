Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F81933CBC5
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Mar 2021 04:15:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dzz2B0lVRz2yhv
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Mar 2021 14:15:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1615864546;
	bh=axa5gq5igfzRH+YmmovcSGozaFBbVeBu8OKzueR+Ub4=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=QvVQ7EOY4MKN7npxlvDl/w0+D1bYT51kD4s79Djxs4KthhfMgaEj2q3gusPfCIUIW
	 fZuRIglBh2xQjRYteH/RS3jIQlCCHBRRbWUbjHtmPhOJryupzwwRtViqhqLzmSIzCk
	 0xv7QQHT62W/ymyXbJ681B+LrmLWHg/GAQ2QNDNTR+q85o7JXT1bz6D77s+0we/hrT
	 ExyJMWKVeIrSlF+0zmokezFtaBaLkYqGTxqO7uqaAx3JE47vIhMNptTdgCVNbM0aEo
	 mxV0za1C1sOPWzX7MTHvAMa0qEgeyZbZ6Rxpwo9/2PDI4wP9I//O7xtlZudcbQv+Zo
	 ZuwGxYu896Chw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.80;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=cTKyx8Tj; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310080.outbound.protection.outlook.com [40.107.131.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dzz256f1Kz2xYh
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Mar 2021 14:15:40 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ei6agQKON1VT1oz3Df/t1NdiQZ376+6cY0Wti1iqiS2tJoSasMWCqSP1aVzFdPGFgWReYBcWSr0S/1p5m4GVbyyCLJPzri0Z8DauSQEl1AtEjl8J3CRbp0SjPzvSxEjEmrnSMsA2u8fw6arEoXMQAuWT/1bwhnFnjZi3Si0RFrp4H819JraWBIwNAyxHholeKUIRcU987uA0YDOl/zsKxrmhiNgG8gp1rriwn7kiNSuTbJYVetpfRvFd2y8BWIGC4xRVHOZjbgYcBNv2aZUk4cwvSXmzEzwHPPSBBeDXmkYfuK2EvnxbdKHUm/53Rvdh19vmuyFASI03y/Vth1FQsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axa5gq5igfzRH+YmmovcSGozaFBbVeBu8OKzueR+Ub4=;
 b=hL4ky8DBQuXULT8sN1SLZAdYJLx8qH3LSHKZwJBjgspiBTuoakPfMK/OoMbOnQ8jYItRiqC168p2Jbnj1v/eVwEuV9crLt3qIg+ds7Fhs43vQnw9qPa3YHibNdJFRHgMoyXDG9ThUgeKZGsxuTYUcP33yzlHWsuaGs3aIqRAFiVcq779Y/c8FX6fpHb6EaHrD/UBhqmXcVGH1TKpBfVk1nIjCRfjSeznDZrdeaqfvdeiRx/PBYVH7OG8dknVfG7nM/2UaidcVCMEQ1ZolAjchcF8LV+hZzjm07Bhw7CWmPR0XhhcvdtxrDB9Qad/VisaMkjD5Shlx2iZzc5x3WP6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB4458.apcprd02.prod.outlook.com (2603:1096:0:d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Tue, 16 Mar 2021 03:15:29 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 03:15:29 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v6 1/2] erofs: avoid memory allocation failure during rolling
 decompression
Date: Tue, 16 Mar 2021 11:15:14 +0800
Message-Id: <20210316031515.90954-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK0PR01CA0055.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::19) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.72) by
 HK0PR01CA0055.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend
 Transport; Tue, 16 Mar 2021 03:15:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08d3ded5-13a2-4fb5-3846-08d8e829c05e
X-MS-TrafficTypeDiagnostic: SG2PR02MB4458:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB4458536BF74FF4A74FA1E3FCC36B9@SG2PR02MB4458.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QjcfQJnv0mDh/54v0Ea3o5E+3wi7xcbEUBfhs8QAV4aog44MFj4iRMfAd9KkUtsoL5FsKr1cNRRwfPnVr91zxQo/EXAf5ZSpgAV9dOybKGt0pto8XTtGutFl9BTUCsqeSIAJeB829thE69Z528tcsiPEW109+mPZdh5QP1JWqcmKhEMizA0R5dZJLZ5W2Fe87aJj7/BF9rr3vVbPgAzPw8vL0NQDb0Q9JrHQxBOKGe/DQQ+ht2CS1FOdWMvo2TzQP3Ms04jXQaTZLG+j1Q2NiucSP2rE1/1vaagJMQlA5HpQ8U5ugBGd0mI5khWK+8CgOnLJhotkwLE2wWm3CNC5MDjNCqYVSn/VgeEG40r9o/xsb5uWIS8ILpXz96Bd7L8Pz7WEn5tElisg23UQes4TytPX4Zp1NCdY8jgdOzMFKNFgdm9kySvztqiaQj1IF4GLgABd1CasYPa0isXpIpiwEu4imbOk4mk6Fjafb3rtPdJ13kD6vzbJFZjE8XwKSE6a+tgaBqBq4OFTkD/sIpq45r7sR5Je8h632m7I9icZXJVhF8EOByCV2MEx1svvVtxSrU6vaQqr87tJtyHI4SD07R/TRwqWWQydFPCY1oFDUNxDCzhd1WiYbIzoaAHQNs21Kq6MDIyuOptLkCNdRDpXLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(6506007)(66476007)(478600001)(66556008)(6486002)(36756003)(66946007)(316002)(5660300002)(69590400012)(8936002)(4326008)(2616005)(1076003)(186003)(6666004)(83380400001)(26005)(16526019)(956004)(52116002)(6512007)(6916009)(86362001)(8676002)(2906002)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+6t0CmrzPfoGm/XinwbcmeUgvqDzObzq2FcdkrHIylwOXNmej3TBh22ClzGW?=
 =?us-ascii?Q?gFiRE/swuQqn4GPVcRpYsGKO830P7FrFjvuABfmkSveVMziTOEbMHOT5KxCI?=
 =?us-ascii?Q?0BTQRNqSPX4DmpcLaD5z4F5zi1tGKZCd5SolP88w1XndUMwacTsHoNxtcZ2T?=
 =?us-ascii?Q?el19I7jwWxskU8+otJQTnJ/9taTuTMtNQPHi0oJ+ruWdXUsGlkLZ57bMzZ1A?=
 =?us-ascii?Q?creaEzZ/po9inIV66sOaLC4qcPFSNKfQjIgzSdwCRTYrCF2A7rb5A2pfPALg?=
 =?us-ascii?Q?SIS+2dwREvqSQXPTG6I3Mgh4MaAlCfueXeY4qghVmT7pGEkAINtHhWfVzrLZ?=
 =?us-ascii?Q?ppDJZrTGVtPzB2/176qJf/LtBeHmUvYQhnT+wQ6c169WUXQk7BsOeEQSB3NX?=
 =?us-ascii?Q?icaHMs6bZoohxiq6SEkbM2uFekS8cFbghxLjojc0enjJdiwpZEKy03ifAwOj?=
 =?us-ascii?Q?7OKwWwQUtzA75ed5lXxkUYkGsqRWMzbNsO0OKtWh870io3Wsu2H7H2wCiY8V?=
 =?us-ascii?Q?JPUQCGy6syRI/OGJ519BadILpctMUOmf+RnQMdXQzrR0Ql00KV99ITWPWDgc?=
 =?us-ascii?Q?HJ5ffLWgvsc2rPKTDrRMszVb8DVKaHfooV8qai6BF20ej00oXxdp5GY6tKGE?=
 =?us-ascii?Q?WyIcUmK/KCq21LuH/JCX33TRjQ45PquhdpXSLgWx0rgf2huD3kE91aShOrGz?=
 =?us-ascii?Q?Tii61yicypGy/lSg2lt5SRYB9EvSweD/ADewniUyd9u38BLCPpdozHq/2xcC?=
 =?us-ascii?Q?+bsYsWtXJpndFPF/lf/ZYZ1lnt6hDhRQXjtOqGmYc87+utbTnaD2Ay4C+fgH?=
 =?us-ascii?Q?VoDPBpOhIgKKXG0kZvgMeyl9NIcHFm9cEpaD/9hwbc7//oJKEnoFFKVUCpt/?=
 =?us-ascii?Q?Ss6J0roKSUh5zyLMw/4Umm6Y2dKbxHP/841xcsV1vUJov01yyjXlE8FySZ/F?=
 =?us-ascii?Q?1t+RDL9Q1Mg6DMD0nNC45Mm+uGnTLbAWC9mrlx1kGZ7nhp7TQZr+QQZAzCmC?=
 =?us-ascii?Q?F0y3NMlJxAcfysvM1Rnkj2wfVbXYZzNOt1jeQTtGVFf8Ea98BL5om9n2Hlyk?=
 =?us-ascii?Q?vljfsiM6MYLGdL58na4paKjMI4LH6HsRO6F5BD8jylizF8FRz9yBvfk2E8Vp?=
 =?us-ascii?Q?zCHr4QJPTJgmZvMfJOWgZYHqcCsHMqgGMo8h1wcFr+RAm/tpj/3WdhnbYI3V?=
 =?us-ascii?Q?nei42EWZ+7SOIwA9gRoUMSxBm5uLqS1x7veqtHKPcZU1vJhl8ae6vBrOx3Ug?=
 =?us-ascii?Q?+VHuAMMADr3E7vrkkUn53oE5ZQxRR6+lL7OUpmNrFIDX41lKEyrb9NA1wQ+K?=
 =?us-ascii?Q?+AnFgPZAK4Dzfu+2Ld9jf4CV?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d3ded5-13a2-4fb5-3846-08d8e829c05e
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 03:15:29.4257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbhUuarduxwlfN6VAbIFdo1mc396DDQVua7zBU+MCVz1UKiP7b8dDmoI2jbQ9dtUfnpinJa3c6AadVe36fy8eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4458
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

Currently, err would be treated as io error. Therefore, it'd be
better to ensure memory allocation during rolling decompression
to avoid such io error.

In the long term, we might consider adding another !Uptodate case
for such case.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
Reviewed-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/decompressor.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 1cb1ffd10569..34e73ff76f89 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -73,9 +73,8 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 			victim = availables[--top];
 			get_page(victim);
 		} else {
-			victim = erofs_allocpage(pagepool, GFP_KERNEL);
-			if (!victim)
-				return -ENOMEM;
+			victim = erofs_allocpage(pagepool,
+						 GFP_KERNEL | __GFP_NOFAIL);
 			set_page_private(victim, Z_EROFS_SHORTLIVED_PAGE);
 		}
 		rq->out[i] = victim;
-- 
2.25.1

