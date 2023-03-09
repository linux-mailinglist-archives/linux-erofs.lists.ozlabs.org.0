Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B99DF6B1C90
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Mar 2023 08:43:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PXLkt4X4dz3cLF
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Mar 2023 18:43:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=eBlMPfjO;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feae::718; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=frank.li@vivo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=eBlMPfjO;
	dkim-atps=neutral
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20718.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::718])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PXLkn1QKmz3cDp
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Mar 2023 18:42:55 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Med4FoJq3q8JwfJwLOJcDsvz80pKd/jmlDpYU4vbVFZgiZPld+SLcYb1JxDNFlCoRefY8a6Q4NruidbQj/6FUXrcMX6dPFbfm/cQfZRjVNBArJtaWQbxJ5j34humSvwfhf5LCsbAC+em34LUKJN8j2i1arEasHsEhMkSDsDEblBdqAC0Vf6uOm0G3XMeQx2t1eR5wRvOWkni//sv6DPjvGhBKwkESydwgQqHsKEkq/yBBlB2hhZPP3XTzm2A1DJF5RuAM5aCvDa2gZOTuiPmTKKXhi8mExQUh2GU8iplnvb9Filtv8F4ZIqZa8qbtQLwSj2l5Ac1XQEV1g1tQ9WCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/56sFD/vWGFmfdCIhAYSYSsNowOEqqj/mAs26p9XlQ=;
 b=cq4aBuGnAV81bAwzir2MM8nh4wL99xIR/09X/JvNmSu5LY4RNzKakttFkUal6JZeddQMUO4yv6Ke4cxhPx8TlhQEZU/nDvHlKtmCJgEtlgEITedsu0YQ302pUHp/xBRqpo6p+Ixq4l0+W0f3NLgao1y2tKtOdYOEVQSDBljc0D+kaVO4VVXH7D2iN3MxVRK9i5cAYIp3/o3GMKMekVwM73MkcC1UkbpUkPxd/Ztp5QDj9PyRmQd3/sbPxolOllez0Y2j0FSbCOMqChX+zENsh/U6O1xTkfPPHSv68i7IbUoSssS0tSYwIB975BA5QVOh2KQpwrr1wq/LzEIjAZQI4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/56sFD/vWGFmfdCIhAYSYSsNowOEqqj/mAs26p9XlQ=;
 b=eBlMPfjO7mI6XlGOuEHIWarSacTgmWbwEzEVBpYm459TNNfVgdZJUpkjcqy79o9WQuNcBc+IFqAe0azuZTMMv01kEmDjg1cmW1cFjnQ/FstzLKlHSfLVAmqa8gkiZtzgMQ6pa0y3Rl4+5bK8b64AeGBvegAaWuFkPV+PCFhLWzmYfRurL6UfIgu+2nQAyK+OBDirYC5ajkweCTLfjIzDMrQw1wg7Z0xeM+mRQEqP0hJCr4lyfGCoB29S99KFANlYREQk+/ld216Iw9EIyyx2PCzTyjO+39HlIVphrLG9VvqG5WBVrnHMS4Jvh/YRGR7Vz7dR2/rk73QLNNZrnSfN7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
 by PUZPR06MB6032.apcprd06.prod.outlook.com (2603:1096:301:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 07:42:34 +0000
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190]) by TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190%2]) with mapi id 15.20.6156.028; Thu, 9 Mar 2023
 07:42:34 +0000
From: Yangtao Li <frank.li@vivo.com>
To: zbestahu@gmail.com
Subject: Re: erofs: use wrapper i_blocksize() in erofs_file_read_iter()
Date: Thu,  9 Mar 2023 15:42:25 +0800
Message-Id: <20230309074225.29404-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <bee8eb33-ec23-de1c-0340-b2cc290f4d1c@linux.alibaba.com>
References: <bee8eb33-ec23-de1c-0340-b2cc290f4d1c@linux.alibaba.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0050.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::19)
 To TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5275:EE_|PUZPR06MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a14d34-aa09-4701-3b6e-08db2071d8b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	rjeOaf0aoCUh6YIzcz7U2ma8/Xxx7VAZ94I47xfKpQX1xLz1kvcl3+9Vhoz3MSbrjpCADjWJT+5r6ou0O81kVqAqyxXGdkH3OeTdJpdnYHRgvR8I/qSgyaJNxjjNqQo0wDHunHgqov5/owLm6/46JqagMzSaWwI9gX/QJPusptJ7mhfLIB5stkQStcsOyKAjphuJJDcK/knwigmObSMfNhUSZUCdnpRgfMdNXRTAkj/9t7qzw+4zI5NT9Emb3hXbEy0X5HneMWJz/4ahStrRGFJx9yVaAJ7DCHFJVXDn0H4saP29d9Z7FH7uoaUf3gI642YfJyABPsTW8cgYTZU7hPe0lfyS71OOxV++RrjfoZUtxeMeVg+MCFFTSPcY1wVVP0koh00sHDPotjKchJ3tcu2PGWPwBl7QQUnMx1xusNZ4cRM10XZUXmmPI/eetNVdSb5iCQxanm2cMvOLonQW8cXkUvWxPrMqf1iE01/x0CzLjOTfY+XVySKRXCW1/Cch9t6T7yIeurkVSm+vgzOPxP/Wf/l3+QaGuo26KjrZhj4jGB50+hER45P65MPzy0YL6X8ovgs8aNBBU2B484dZtEH4zRtGAbTs3OBVOJZik9U2uFFBnq6Z4oBOgFk00+6yyWuEtb5C+937zYs73da6TyXEfGlMVjHreBY4S342OsuLMW+T6+QvWCBPDYIzM1aI
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5275.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199018)(8936002)(36756003)(26005)(5660300002)(1076003)(8676002)(6506007)(6512007)(38350700002)(38100700002)(6666004)(83380400001)(186003)(2616005)(86362001)(316002)(41300700001)(6916009)(4326008)(66556008)(66476007)(966005)(6486002)(52116002)(478600001)(66946007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?nnKqqnffAgg1HMvMQtlmwaf/3oFAbUWkI4v4U8Nh5mp+wk+hykA5ky51ZinW?=
 =?us-ascii?Q?NmA3O+cHp5TTkjEuscTYKeRueSNkYTufJj5q7NGS3fPrpCK3fn8fLU8rhmV9?=
 =?us-ascii?Q?uNOOImRnQ38oCs7rB8rV6OihdRbYI7B4MN2qL6K9BahSLue4i1tuHqtE11Vh?=
 =?us-ascii?Q?LfcTblR3dGMESFntjW7/vImqxvrvWrk2T4UIGNq6tmTM8SPTRv+44vqkKxO6?=
 =?us-ascii?Q?cTlQy7w7UtbEUcAXDtAVrSXu10fhNqGfG9SLcNxPVxZKgBrbdQYKZBwYWtkm?=
 =?us-ascii?Q?dRVjiL8lW2mtUZNStR05wZ/PPjfMIH+PXqHWu00eLe6OHCIV7+3FOmqZaq2Q?=
 =?us-ascii?Q?oupfxOVzcN8gIQwKrb7vjCfFAClWA79bqNUbO2QsPfYTMXmOYOOvYTVYY6cx?=
 =?us-ascii?Q?zyA7M388chCXvZ0v9S62DFX+KIgSq0mvsf0q24IaBDNxgbklTSJjcJjwmLep?=
 =?us-ascii?Q?M47rONXOjClIJqQBgSYqcd999rzcUf01exQqRgtgCwEMiiCU5sy1fN4IO1AQ?=
 =?us-ascii?Q?wxmpEWoP2l/bJ85OEGS+BETT4qJu6OjO8Zt9V7LvRZP7HGrX/VrCN1zuEiGE?=
 =?us-ascii?Q?S1AYmFAsNHvdpK2hmz+pH4QiP11NZRBFBkXJVMdjsYcx4N4BzJIBXXu0I5E7?=
 =?us-ascii?Q?3xI1e5HEtVu8E/Mh+rTQQLExJDORgpbXnm2MGJpai/tww+7/6v2cEOWK2/Ox?=
 =?us-ascii?Q?oPPvd+VTDyrDnMzn4OxKpeoWwQ6itnRKVdXLYulZZaHG0hoxiU/qARJU45cj?=
 =?us-ascii?Q?06zw3b+k4lUMFMNEtdSCNuSd2UPbvrXwaNyOwf/wBLU0YD4Qjxo2fV3kdnW3?=
 =?us-ascii?Q?3+IuTL+MIO3Z503exaPAB3ovR/Om9BuRH33Cxw4S5breaZbU0wTcm10eiGRa?=
 =?us-ascii?Q?7xG95YvqVXBAFiCdoV4DhV4I++kh1zdooxw4XVhfEEdbm9LqH+lkpo2P6TNH?=
 =?us-ascii?Q?WR09dw/t/rQzFrDVmxYDNFYv/HGUUrEnf/YvAHLqayNsGopb/nYYftNHA0BA?=
 =?us-ascii?Q?UFH2dEWUQMMLUy9ndeoQDx7WQYeL0e2fT3PS03xJYGUsH8QdlkXHZhA0C5yI?=
 =?us-ascii?Q?M+1QOhiSG639eFZdVpZlAbbTfLUPtCLRiNxoln7xtyL6pecsHCFHwsysoEY9?=
 =?us-ascii?Q?KvUgmLf27F0dgfolqpdbwsLUU36Vfeyy8ZVzYAtbFrSIJVNEnHG3ftkzQAg5?=
 =?us-ascii?Q?CF+CnK3CnYgZLPEgZVjNDaitQLNnk/3/ko2umfOzFx3Ti3UWeo9ZmMeKAyyz?=
 =?us-ascii?Q?YgBJKS4VA6r8S5qfTbioUZ3Td1mOz56vvRkYT7IRipoBgJshV0tgrgxALX+R?=
 =?us-ascii?Q?RWrCRin2ALnylnox95ShoKFZEuwS+8lFiF47qbXYCHnITh5clFC0YzIcR7nN?=
 =?us-ascii?Q?Hd4LOzGWya5XLBpEjhlOFwd96OxFksuKQHWEHA+4x5wgiw9hJJ2btZ70+6vX?=
 =?us-ascii?Q?rQbu9Nq4b2YRwhr+Cnk/Ssontgsil84FuJRlrwC8qGt/om+mTl865AlqlTFd?=
 =?us-ascii?Q?Sq7wneERHfuK4+lz915cekLDxef6ObBZby7BPlG6HrLOoWBhRDsyaoxrNddq?=
 =?us-ascii?Q?IRpqP1T1WeQ2R1odfpZeXqzo7uNX186aYxmNkIHI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a14d34-aa09-4701-3b6e-08db2071d8b0
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5275.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 07:42:34.3128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iu0RWUlloy69WZakEKQaGus/E3ut9BN7Akewz8KlwaZ+QMCgRrfINgKb17hMAqYNwm5x+Or4HCYYdbAUhVvLQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6032
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

> FYI it seems that GENMASK macro is widely used in driver and arch code base, while it's rarely used in fs, except for f2fs.

I think the following usage can be changed to bitmap api, just like in f2fs?
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=c4ca1f7164734a1baf40d4ff1552172a07d4fc4d

fs/erofs/fscache.c:135:         unsigned long flags = 1 << NETFS_SREQ_ONDEMAND;
fs/erofs/internal.h:250:#define SECTORS_PER_BLOCK       (1 << SECTORS_PER_BLOCK)
fs/erofs/internal.h:252:#define EROFS_BLKSIZ            (1 << LOG_BLOCK_SIZE)
fs/erofs/internal.h:354:        return (value >> bit) & ((1 << bits) - 1);
fs/erofs/zmap.c:66:             ((1 << Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) - 1);
fs/erofs/zmap.c:69:             m->clusterofs = 1 << vi->z_logical_clusterbits;
fs/erofs/zmap.c:114:    const unsigned int lomask = (1 << lclusterbits) - 1;
fs/erofs/zmap.c:141:    const unsigned int lomask = (1 << lclusterbits) - 1;
fs/erofs/zmap.c:147:    if (1 << amortizedshift == 4)
fs/erofs/zmap.c:149:    else if (1 << amortizedshift == 2 && lclusterbits == 12)
fs/erofs/zmap.c:169:            m->clusterofs = 1 << lclusterbits;
fs/erofs/zmap.c:291:    pos += lcn * (1 << amortizedshift);
fs/erofs/zmap.c:409:            m->compressedblks = 1 << (lclusterbits - LOG_BLOCK_SIZE);
fs/erofs/zmap.c:457:                              m->clusterofs != 1 << lclusterbits);
fs/erofs/zmap.c:497:    endoff = ofs & ((1 << lclusterbits) - 1);
fs/erofs/erofs_fs.h:120:        ((1 << (EROFS_I_DATALAYOUT_BIT + EROFS_I_DATALAYOUT_BITS)) - 1)
fs/erofs/erofs_fs.h:279:#define Z_EROFS_ALL_COMPR_ALGS          ((1 << Z_EROFS_COMPRESSION_MAX) - 1)
fs/erofs/erofs_fs.h:377:#define Z_EROFS_VLE_DI_PARTIAL_REF              (1 << 15)
fs/erofs/erofs_fs.h:384:#define Z_EROFS_VLE_DI_D0_CBLKCNT               (1 << 11)
fs/erofs/erofs_fs.h:427:                .h_clusterbits = 1 << Z_EROFS_FRAGMENT_INODE_BIT
fs/erofs/data.c:379:                    blksize_mask = (1 << inode->i_blkbits) - 1;
fs/erofs/zdata.c:133:#define Z_EROFS_PAGE_EIO                   (1 << 30)

Thx,
Yangtao
