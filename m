Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC0C6C0958
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Mar 2023 04:35:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pg0jz1fphz3cBK
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Mar 2023 14:35:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=AJe7Jj4y;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feae::724; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=frank.li@vivo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=AJe7Jj4y;
	dkim-atps=neutral
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20724.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::724])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pg0jq4TJvz300C
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Mar 2023 14:35:10 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEhCxh8D02rcHC6dO7kSOfQ+AGgqO7UxxE69tDyIm4Tqs3aweJ2dCq3UPkCLzV1UZ4dCLggR86K54XogG9H75P/5oJbWN3Ba6Wj3cGM6kQ42z+B4bFqJ7+nT4QasBoWWWNjZVEgCadrqhLpDCGGlApiRTNukDbmIEwtYHlHziyn3tLOFMVSeP4xPlntuwMq1LzzQfOpwWSp56AJ/ohgpVKYqPnOHJZjrgFkkxoNC7gV68ucQZxKEnI+wUcVzya47akjjoTVLURODESNAW7SDu5/xOkqEZJi8jBA7od1DMqCyN/EIGgQKBjL4MJQ97gRM9taOqDh8vMOb4eA3AmXF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcSocjSGVTF5aPxsLKaFBjySrnM82IY/w/dRKgIVLtQ=;
 b=gry7E8prSKnGmd/mnLmfUklTMk8F8AMmcWZqTtxEv2Grerwl0LY4m7aQ6ZY5ZkwGG4gRAE87lSYHjrqeNyYtyMMWY8RnHLmkE75DsqpKupAdGopskoG76nqzkrtz1G38ewu490FMsWiNviE+Mk4nNrf7EcETDNPLPwiNMaRJrXZWNSPW5QzWZBB2BJ8FpGyc8eJB9nXNOu6b0+JijkLVRSEDCQx8wbW95+aqN0L19GMhgUvlAVBizJbsGCG0og+du33uwgxtamFzQrDsjzPYZfXOjIXMO5IZpGDVHxDa2tNSRVrmGfcOCG1ZSFlZ/UNoNdq4D/Uj1QqgWxdM/XkWCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcSocjSGVTF5aPxsLKaFBjySrnM82IY/w/dRKgIVLtQ=;
 b=AJe7Jj4ygTrfHsWmTT4gnppAGvUAtxhf60mNZ9snE2grxP1YAVIKUBTbJ/FhJ5/07pv8NeiaL6A0EZa+g5rqelTm3a0QrRsAiby1xgmZIMDm2bFMzFic3A4Ap5WaN/3eXitQCTaKrI5A+3QSsXTbt2M68c4+uZktefL9Z3fLqeW6/lu+5gysxjGPeHLC9oRgqOFrQBpJs4tJfyf6Rq2xGn1cu82nJjuy1FyxVvwVKYWDfDDhttvFoqM+VaHI1Wg1Z76w3xT8mXwPlMgZYh/Mo3P96N+cvuT2fYhTrbVfImLo75Husxpwqnv7+ngdcX8cHu+TQp/EiAT08AePZWmV1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5332.apcprd06.prod.outlook.com (2603:1096:400:215::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 03:34:48 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 03:34:48 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	jaegeuk@kernel.org,
	trond.myklebust@hammerspace.com,
	anna@kernel.org,
	konishi.ryusuke@gmail.com,
	mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	richard@nod.at,
	djwong@kernel.org,
	damien.lemoal@opensource.wdc.com,
	naohiro.aota@wdc.com,
	jth@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org
Subject: Re: [PATCH v2, RESEND 01/10] kobject: introduce kobject_del_and_put()
Date: Mon, 20 Mar 2023 11:34:36 +0800
Message-Id: <20230320033436.71982-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5332:EE_
X-MS-Office365-Filtering-Correlation-Id: f751e256-4fc1-47fb-8f9e-08db28f40e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	wKv53Xg11R61xkWPk5mnClQ8de5hrpPWB8AtDbwQpOKWpR4TXtFRutbBhVfXYH4DJ/Fn7Uc+kee0v3FfsmfoCGKYw5Dqn7O6Cl7WWRXXfYDhl7o5kGtWqGOIfdSt+2RJPg1iUeifueBc3OlZb0UF7GUrerp95f10B5uwqhHFdR/BMn+HsajL11VjH0aY7jZ6ApJOC7NDOChCoO53Fkf1afmcztY5g+7L0qfc2lffod92lIaWCBcd6xqLok7w6Otx21yGeuY8ujiXBKEV5IqEisg7MqgpkDacRtRk0i6ZRWpZoZDGaeSU0S/Im1JXWfsifOgwoVfjS+olFjwJyhx6V/RZw8TJZJxJFhgRZemJjDpYSqGe0j1QtO971xFWo7GA34jPFEzG2M63xnpXCtnucsOGdijZDAU8CdD/1C7tbB8Al+Z7JJHoR+3wAp9DITt6TVM0hSrddjGTz702PBOIzx0pik7kONo8x+qeadcN6AGfbQ9aRyv1h1gG+xIyoB3EuP8LsinkxT3gLiJ3qoju+Ss23clyia7rf78Q03tj6wErySRJGfo/P8QikEvF1C8YbVqC4FfTu/1OJtXCSXj8ZDaKM7IhDERccfaehkWxuep3cqtzu0MgkpZy9UvFsNbEylkeKRo+UgjCle131FWoQ1yQWA/HQIWtJQvUIF2NK3Jj265bMqBRoDaFBefcMI/Hdcy3NsEuFV8xo719E0d9Yw==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199018)(316002)(86362001)(83380400001)(36756003)(186003)(6512007)(41300700001)(26005)(1076003)(6506007)(2906002)(8936002)(66556008)(4326008)(8676002)(66946007)(66476007)(2616005)(6666004)(4744005)(38350700002)(38100700002)(966005)(6486002)(52116002)(5660300002)(921005)(7416002)(7406005)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?bOVviU4OLZJXsyvg+Cb0Zd596sZD6jRFwETNbK1ENMei6KQLqPYkZn/LWAod?=
 =?us-ascii?Q?LFlYVQLzwo8ZkahzIgB9vkOYF9xWmlRxFJ6XRH2kCXHb5W0cm69FKoIB+IpQ?=
 =?us-ascii?Q?GHjuHbM7LAdvFXK26er7Ca4bPDbl/fCXddz5xckZu+/WFjvozf45clS3WlSQ?=
 =?us-ascii?Q?ZpTnah+B0wvHpxem+IYteQU0SwUGQfpEMRtOYbLyL6qAgF6uLWLyzt3756EQ?=
 =?us-ascii?Q?FMIZQ1qa4D2vFqz9IVIxtbu2KR+MUeiWandNIubSwD90yNIXSSPL3CRR7Kt2?=
 =?us-ascii?Q?UusFHeFqL2ZqdQGEkGmZPlhRFz0l4LaZKOgmzaiz2TvXy48bsydY5EoVC1Bx?=
 =?us-ascii?Q?c/9c8/gnepgZqLafuQ25SMlRkyINhLjju/CkTzLmJSFyWvVNr2CF4s+aj2v9?=
 =?us-ascii?Q?PTk/sv1C5pG0j+pHmx3vYdG+18eu/36mz1+MLUjt7KzrRTi58NncC2+0JTEZ?=
 =?us-ascii?Q?PLSdCL4Cp5NM77atOMH9fsIM3/VVz0sKqV2ICmanDVZI6ytbpObbBGU+bLhL?=
 =?us-ascii?Q?7SQy5atPh09G6KyykYMqyvIBWdB3T59fR+d97iAgPvGwCNBrSCehASBAcpmD?=
 =?us-ascii?Q?IqeJ59M2DWghrEpHRvyxap0VLXHY8N3f2BfUqq2NAXx3FjCAAUwasD2OWQNR?=
 =?us-ascii?Q?oP/b+x/deMyJcfGccGjtfBicWhArQgNBFT+kaRIfqNEiDIHFDUvMgb0ocERb?=
 =?us-ascii?Q?vdVbavspQUeeN9J/Og0talyjCFHNaJ75gQfz0MBvb7FXZjgPDRkHQGV3NoWG?=
 =?us-ascii?Q?R6zd4sJkyhgSHp5DghjArtkDyVPb3W1TOhcMMpQN0DrG/q7laXgKYHBB8Gs+?=
 =?us-ascii?Q?1xjv12UqQQBnOaXb8rmN4ltbQuDzHAiwlWVkvOCnN7XF9Q6ATwIHwPaIIHgJ?=
 =?us-ascii?Q?9c8obY9R+9cJAlZNFLWbXZgMr3ubMCyUooH16xG8yMoUPguLfy27PgiEsX2E?=
 =?us-ascii?Q?4CABBhAlb47zI9UEmWX3c6qoV9H1Z9c6ImmtB4G/qVGAXiYTv75Oni4VLOw0?=
 =?us-ascii?Q?Rn1MVMpc0uemHzcJ8QsYiKJOw1u1jI98d3H4l7qKiK2tqedbEBoe0z3nLiZC?=
 =?us-ascii?Q?RIOuLg9i55zHr3Z5ADGDOuigyjPSsWkEKqtjIOmUHU82tp9MUVDyowDA4AsN?=
 =?us-ascii?Q?TkTFLvQlKbg9lLVCQ0YkuSJT1fL78Zrjs1VmyVN+OLFbpZucVKY7vSOugBvJ?=
 =?us-ascii?Q?DUQ80xXsUOiY2Prv9xt1L/p3L5A1Dkdegk+hytx9NAp86EavEZjmahLYZdHX?=
 =?us-ascii?Q?VDyaqIWm2Wj7xIO05JdwEiKk8aNnXlaAPklbsh0b86kGhRJ2Or3S8d1SfEKz?=
 =?us-ascii?Q?4Llmo3ydrxoXnM92o+riWRsOUoQxo4kyFK/cUTbYeUl2KluYmYBo3hwoyG2N?=
 =?us-ascii?Q?MNy+uxpZ5Mr7yp2cP9iA+irRpXiQSu9n1LY9SI6PENKCAO8/XgjsK2/K+Oqs?=
 =?us-ascii?Q?d61g+cMbVL5QdiYE1PxJz8xlMBFO1y3LYZymTzbyfVvuzpwOug/UAd9y+85I?=
 =?us-ascii?Q?4Oo9UrWozu5FOUmkgGxE3a9SDmgtwR1haH2DcGDVSqtZbM8YJTcSv3otjWoe?=
 =?us-ascii?Q?plFj9G8asOeg74gqs1ExMB/ErjQMGIVhsm0uOCwr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f751e256-4fc1-47fb-8f9e-08db28f40e26
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 03:34:48.1827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERXWBy66ojC7BGjyoEPIS3BCt+Up0pT8AUuN8PWEg2BC2RV9hvUWam5vNjfOSBOyJhCm7utXsOgYJTYwzm48HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5332
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
Cc: linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi all,

Out of consideration for minimizing disruption, I did not send the
patchset to everyone. However, it seems that my consideration was
unnecessary, so I CC'd everyone on the first patch. If you would
like to see the entire patchset, you can access it at this address.

https://lore.kernel.org/lkml/20230319092641.41917-1-frank.li@vivo.com/

Thx,
Yangtao
