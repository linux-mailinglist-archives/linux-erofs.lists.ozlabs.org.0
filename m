Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A1F900817
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Jun 2024 17:04:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1717772646;
	bh=SR4ORPYab+nACGyn8QGiGYRguIGST6W8IbD0XuNB9J8=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=SfroEByaf+DsscXJgzKU99YJxTDktD8vqaysC08YAP/WrRUdtbyrR4qiqC62g2oT3
	 Q7iiIFzCRA3KzTK5FjeSjqcPrgi1qoqmRhM0ghqIQNy+kQspaEMQ+nrpdXx5Sn6JoL
	 2H2YBR82xq1HB+VdT0slKFhtLz6nXDT6iCa39vF2BEi+FDcV4x+hngzDypFGloKjKb
	 FMbBbeYnxIkJ3EihYH3rqlS7hqvQDmqeBnsAoiKfUSK+l1fVxPlRIuxth/rUgDxWw2
	 G2okuKza/ceHK6SUKomo1cHrzvftDSPKwF2iIqfgmQS1cGn1+tBi500PnmPPDXDf35
	 L3n6MYgQYtccg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VwkxL10cKz3cCb
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Jun 2024 01:04:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=W/CiiJIY;
	dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=AcWam3Rd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oracle.com (client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=john.g.garry@oracle.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1420 seconds by postgrey-1.37 at boromir; Sat, 08 Jun 2024 01:04:00 AEST
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VwkxD0GNdz2yvv
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Jun 2024 01:03:58 +1000 (AEST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CuY1A020017;
	Fri, 7 Jun 2024 14:40:14 GMT
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbsydtqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:13 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457Dveui015675;
	Fri, 7 Jun 2024 14:40:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrjgqm70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Amd2z7s04VwPYU2eMc+L/talhARRYSpeAyxQUgg4xqatfc/tUayfnbm2x1r0wb89/Lj72X4OpVi52xvgWrH0xt4DvTRVUPji+dk55BerUlV0l9s7tz9JcBU5nVcjuVskTcPY5IhxSxMDOitAUGmcCMrSgJ/bgwnYmHezSv+FUivRskvoOp/+rMsZQ7Rl3rVVzXR6YKlKt1oRJ5HkIEB2alwchNDvhKzDVMn9sBM9znsX2Gs9z9aIpMUNGzqCSpWO729F+tucRIDy3KA8il6HXLYcenEtAgt/fR/bQjl9STWkgWr7Av5B/DSnQHcjZO+mXGtC9KWENjeqOkZPZQsgxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SR4ORPYab+nACGyn8QGiGYRguIGST6W8IbD0XuNB9J8=;
 b=NiC4owSwo1nze/iLXxTpC8DiEd/+xS5bABXfOoxx03LbyRH/+k9qv8c0NgcdYRmz+ghTmfzqM2SDBkP8kaG0mgopzCDnSxMcq21idtPoA4X9QLFBlVSe9DDslseLR7CVicLRIJDObuCovVD9oTen1vyUUMQgeKanu4Ah4sXNUrbRCKxLnUv6Viqul5rsWNLLTvb0k8aoLim7phYhC3LfWVUiwbvL0LQZcDKjVyun956xQipkN0nMc8J7rXse8shTiL8EW9JYZzh0pAgtSdsxDmMnOnwNdeqUYnhGk3Duta2RxziXMF2bzPYfpoQaX1vTlvCuqPebbYcPvqcT7g+h8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4170.namprd10.prod.outlook.com (2603:10b6:5:213::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.35; Fri, 7 Jun
 2024 14:40:10 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 14:40:10 +0000
To: axboe@kernel.dk, tytso@mit.edu, dchinner@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, djwong@kernel.org,
        jack@suse.com, chandan.babu@oracle.com, hch@lst.de
Subject: [PATCH v4 07/22] xfs: make EOF allocation simpler
Date: Fri,  7 Jun 2024 14:39:04 +0000
Message-Id: <20240607143919.2622319-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240607143919.2622319-1-john.g.garry@oracle.com>
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0051.namprd02.prod.outlook.com
 (2603:10b6:a03:54::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 83416f4f-6c10-4796-4506-08dc86ffbbae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 	=?us-ascii?Q?BUkw5dL0dxed10IM3iVKGiXcDPqGNdLIeX+W7D6OSyGNWIVK4cn/gIWsKHDM?=
 =?us-ascii?Q?CdAZfxWWtGL7WZug0ttNRSKC2L/hEH2rFIvKnrDZK95Kfd8jD+vvJ0+HZX20?=
 =?us-ascii?Q?6kIle9SriscjD/f+oD+AtTUxrRANabEfrD2P53AF3jXREFgbcI3oOdYpA7qD?=
 =?us-ascii?Q?1vj9M7z7RExEytOrH7ejQEMWrUNiQU0plrgA9xQrC/IYATioJJA91aI7LNBB?=
 =?us-ascii?Q?AWJ2Y0i5URnqfwQzhV+7CGFQ/FVyQ0wAfxrhGB5nt/LwP/2l9HgLNDm/bWY1?=
 =?us-ascii?Q?oXE8ef5MlhR38JAmmL1eY+Ji4soi8sWM0jIdffhpOzXwJUpJJW9R1HqDECzP?=
 =?us-ascii?Q?emnoAcVav4/JW9mH5/SVqnF3Z6H1JYScFsruuD5+jGrDBt49tQ7BHcivydkY?=
 =?us-ascii?Q?sqyKcPfnHmU1tNaPhAdvwD5GoRZTR02w4uAaoD7DGwvG1SmS2kr5RqkpWI5D?=
 =?us-ascii?Q?TGs8gwW0+wTsSz/ZnytgLm/gc6RgTNF/2BM9KVOvvuWLlGwSvEeUyN8MjCTL?=
 =?us-ascii?Q?IPxr4xHfwhd04e4FVGy0RDFutSPZwWGPfWNEyClwgz/4QSYq4XZn1YjusLij?=
 =?us-ascii?Q?gSW1enkI0mRPH2ngrM9Z83bmiTQYx4TY0WUB301T4AnXoH+Kv7hdKTp98tl0?=
 =?us-ascii?Q?vUXkeZo/QsE3k5HHp9VHLkY/CXlh9K/rGSu9jvBA/kGrJsv8Eq60DqAdZoB+?=
 =?us-ascii?Q?Qzn+3gijD3pflOg6OzdLOf8MxysgiEB9Gqeg1SqXurI0y3mgs2IOe19wJ1tG?=
 =?us-ascii?Q?J7KgFELuvuDESLqV3cQVxLMRr5OT0+Zha1LfW2K/mu4hT3N7BI/QESi9k1hB?=
 =?us-ascii?Q?qzE/ZzVsSruccu1ponS+zmm9/68c4ZnAz5WQFP/3T1HOYxiFeM+VFwLEXaAq?=
 =?us-ascii?Q?+b5UuGnKEE0OIWoYrj/xmizoaqnk8+sr/6EdwlLnflU9LXOn+IO1oIo9Tdrl?=
 =?us-ascii?Q?R4Vif2eBdJ0iImiMFewpXZIV6WXG0DZMcmGSMRVBf4COjstTgVrtlwoCrvWI?=
 =?us-ascii?Q?Te1KDD0kV2AQKV0Z/nOcWloKYoCRCDZptwy9rKlBX7yTioZXMPULYZG/wyIP?=
 =?us-ascii?Q?TLoi3bzXMgGwd1JFpeHQiEsMznWWEzJ26uhwXGxXgzliPGWPoOLHo53JYj26?=
 =?us-ascii?Q?hEvg3EFHgKc6jzb+lVIx/PPUiByWLtG+WrJHzybgnnwigZtx/eS/icdPBKEy?=
 =?us-ascii?Q?rUMS23C/G9PvtCKXlcjUq66n7+aPPqS8u/2L/zi4dGK90bdodKw73WxLWAmn?=
 =?us-ascii?Q?MNoSILNimgKM5njeZ3jKdhffeNOtvZ4+M4zkTZxhFQAjdfrKGfInwBDn+MaA?=
 =?us-ascii?Q?qyaVHTIEmBbM6hgNp7p8CmR0?=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?Qa9674e3J/IMkMuy1tnhzuHkJrcBskKTpPpkKi6FCFwXMFtaTAPb8/5MiwxA?=
 =?us-ascii?Q?FGfaVZzPGpeoTrHStUNyLnTooovsj9ilbme31HSQ3IN+M1zjAbJOdMJ3iM8g?=
 =?us-ascii?Q?pcXyudTPC+fv99xuxqVTtdZfLNQEVn0ZE21G8FrmZ6ckfYgyNXxShLLxXNHi?=
 =?us-ascii?Q?0GyAfA3zPW/euJ/FxohZO+bA7Lyj7zQSQsT/VDx76/ZAD1Js6QQFK4bjdX2f?=
 =?us-ascii?Q?Ci2nFlf8ltQKAkYltnPlOB/HTbdkS8KoSCfl3Zxqg6ZhCwp7fAC/4xcHsXcK?=
 =?us-ascii?Q?ntlZBTARF8gguEN0r2BVQSPi7yqatoCyKFc/P58pcUYm6ycRoCk9UZ4w4BOS?=
 =?us-ascii?Q?iQlxUjf6l1aFWTqvZR5MGDX4MgqVVAb2L0+DFYDSOA9NR875QoMsdDIzPY/6?=
 =?us-ascii?Q?C3LxM7JRWSoxKP9hzzrFhUrzlej3VQ2n2YUauOUIXNH8gtngGQsFX665oIP7?=
 =?us-ascii?Q?o8UD2eiYd7UKTRMiNjRbVeHagpWWDWJkS2BE9PR+zsoAqCRA2BNacTjR3jUP?=
 =?us-ascii?Q?9QYLnfzb5IqoGrdj2VoybJUJ4Opk6o3P4TOITxhfQvqOIeahaXNnEV5Uqsag?=
 =?us-ascii?Q?nwtkqhA8bCM+YM2Ybl9DYbMJArt6WbS8VyX4T9tI+Ttim8AQitmTjPS7Ee5f?=
 =?us-ascii?Q?/yI0RsL7ocVwn7ukttaHrCWmrU7+LISsVBk+bX+DoJTC5jFXbskfEXh0P1P9?=
 =?us-ascii?Q?FT1iLK9VhGelzIwvnGNAi5lH9CYlYZPrayIgCEtDcXp6no08exsgOj6EdHzP?=
 =?us-ascii?Q?/DFGEvYNHOSstHMBqh6VgZ/IOEC3lv58plblWmuf++l0Xh7SmwQAP4d3yGPK?=
 =?us-ascii?Q?OzhYRXQcH3ZHkYGPK59AJ+zG6FURFDTq80vb52ff3bXRHhMk2fpSGC/yZxzb?=
 =?us-ascii?Q?w/m4LTN/UEyGxQmKDWOLuyRhY86U3TUOZVxsd6gc82q+lNdbpbZ2djkTiP2C?=
 =?us-ascii?Q?yB5NF120lISn5HKmUMF1U+a1pjvxdIL6Hi2P3eAgAd/SMz9UTkfsLZ5PeQuk?=
 =?us-ascii?Q?YgkROCNFOYp3dkL0DzEkZWHL7e9YA/36yjfI37RQjhI+DJKMI73z2HE4J8eZ?=
 =?us-ascii?Q?Rorq71b9jtt7CbJb9KifeTlBdOQrJtN130Vd3lsjlke1mHOJoCGiz2ZLAo3I?=
 =?us-ascii?Q?TCV5ERNPA7BrCXxDtByvh2wVTzfcv0XSGIEsguALLjuU+7Fur5If1iaaE/ZY?=
 =?us-ascii?Q?Q5G9ku5hMoViTGTs0hX9GELo5ja2kawQPiHnIpZyZv3kD0gP2IOTmIkFquZ7?=
 =?us-ascii?Q?NYQM2xOEqLMSSMksyef+/5BCOGivuq9wgbbvO6ySo4yX03BDsdNQH2Z+if/l?=
 =?us-ascii?Q?US7CnButwny7JzmvJuCV+cY+B1v4Pj5/6+mHg2M6c+hY0nbDxd5+ycYd6eiT?=
 =?us-ascii?Q?bA+5CZV6hTe7N5OmMgYBzHmj9Ra24a5vdILNBB5RNR+5IQ6SG+5yNSNgEWCT?=
 =?us-ascii?Q?sHiapKW8apIyF6sCCJ5UxyFCrVwsyKAlfjMTzZqhhsBQuZc9vDmEpaY8cvl/?=
 =?us-ascii?Q?utBPjlZu2J124t+JoTW1kDor6eoAc2wN1ooQcBJJKc2sG1AqAFIHcxbd9Bkw?=
 =?us-ascii?Q?gPE97AfBRt7KB70JSQfX6KDYzhpeNNDPlAZVJaxI0Bhz08v5D3kOi/s3fE5n?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	RwGNQM86yZbqQjsqjFLprHcwwBcjrnJBd1RYY/XiB1yABxkfh1j02Xu33SbQUqFvFgca0cfw5yIIQDqqC0E6IidsSc6ZnBdWIj7hRKMZ1zNqG1We1M4JM9pLEyJQdKnh8/Esm0BHlOEzFytSWoF2rapCj3JER/E9SZAlf31R0bvAYb4qkEaUJqKisYowzqzhO/EEPCBH1QAO+KlfxTSeWMN8EyKKwoQxKbC6w4saipxKBvvPZE5hq0n/t6HqQxf/qTf5A2ldaaUrhM4fdZA9z4YUGC5ZYcP2MsW3+ciFiLWW5vAxOwc5ioBALYgBq/zn8D1Mf2CcJoSGDBGXE8uYFrwwzEj2wzm1AWZ7N58a/O3IviQw40BKhwdh6D38ClPnLXlAv2Ky5Ykw5JMdoCYx7Vlofg76G0Q0QTheeei+DfaoU3D7JgoUnkpNUf4A2aXheBOpNWdVilETnWmDpJ0JdPxijSf9LtGkAONbJNwH+U+9OxSN1yBuo0lqA4bjKNHWCoSDmEdBRbkFr9RvnmriuaxA2JHUxDiDAPaR9fio9ThKJszuNnXZ0GAcLYUDjOhxlsYw1/UI3iWnJdW3e/qxqsArow0rCpusYQUo/sxzo9I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83416f4f-6c10-4796-4506-08dc86ffbbae
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 14:40:10.5639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNsJ/MOCdt4n2YgCGEbA5IwisF41bqoGNWFvHBlUw+4uj6wcbUlmg/w+ZHB88h1DHx/u7etMufMxPzH1F/zXTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4170
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406070108
X-Proofpoint-GUID: V7D9tLzDmY-aso7moHyqaKqGrZr0njv9
X-Proofpoint-ORIG-GUID: V7D9tLzDmY-aso7moHyqaKqGrZr0njv9
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
From: John Garry via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: John Garry <john.g.garry@oracle.com>
Cc: gfs2@lists.linux.dev, catherine.hoang@oracle.com, agruenba@redhat.com, martin.petersen@oracle.com, ritesh.list@gmail.com, miklos@szeredi.hu, John Garry <john.g.garry@oracle.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org, mcgrof@kernel.org, mikulas@artax.karlin.mff.cuni.cz, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Dave Chinner <dchinner@redhat.com>

Currently the allocation at EOF is broken into two cases - when the
offset is zero and when the offset is non-zero. When the offset is
non-zero, we try to do exact block allocation for contiguous
extent allocation. When the offset is zero, the allocation is simply
an aligned allocation.

We want aligned allocation as the fallback when exact block
allocation fails, but that complicates the EOF allocation in that it
now has to handle two different allocation cases. The
caller also has to handle allocation when not at EOF, and for the
upcoming forced alignment changes we need that to also be aligned
allocation.

To simplify all this, pull the aligned allocation cases back into
the callers and leave the EOF allocation path for exact block
allocation only. This means that the EOF exact block allocation
fallback path is the normal aligned allocation path and that ends up
making things a lot simpler when forced alignment is introduced.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c   | 129 +++++++++++++++----------------------
 fs/xfs/libxfs/xfs_ialloc.c |   2 +-
 2 files changed, 54 insertions(+), 77 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 7f8c8e4dd244..528e3cd81ee6 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3310,12 +3310,12 @@ xfs_bmap_select_minlen(
 static int
 xfs_bmap_btalloc_select_lengths(
 	struct xfs_bmalloca	*ap,
-	struct xfs_alloc_arg	*args,
-	xfs_extlen_t		*blen)
+	struct xfs_alloc_arg	*args)
 {
 	struct xfs_mount	*mp = args->mp;
 	struct xfs_perag	*pag;
 	xfs_agnumber_t		agno, startag;
+	xfs_extlen_t		blen = 0;
 	int			error = 0;
 
 	if (ap->tp->t_flags & XFS_TRANS_LOWMODE) {
@@ -3329,19 +3329,18 @@ xfs_bmap_btalloc_select_lengths(
 	if (startag == NULLAGNUMBER)
 		startag = 0;
 
-	*blen = 0;
 	for_each_perag_wrap(mp, startag, agno, pag) {
-		error = xfs_bmap_longest_free_extent(pag, args->tp, blen);
+		error = xfs_bmap_longest_free_extent(pag, args->tp, &blen);
 		if (error && error != -EAGAIN)
 			break;
 		error = 0;
-		if (*blen >= args->maxlen)
+		if (blen >= args->maxlen)
 			break;
 	}
 	if (pag)
 		xfs_perag_rele(pag);
 
-	args->minlen = xfs_bmap_select_minlen(ap, args, *blen);
+	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
 	return error;
 }
 
@@ -3551,78 +3550,40 @@ xfs_bmap_exact_minlen_extent_alloc(
  * If we are not low on available data blocks and we are allocating at
  * EOF, optimise allocation for contiguous file extension and/or stripe
  * alignment of the new extent.
- *
- * NOTE: ap->aeof is only set if the allocation length is >= the
- * stripe unit and the allocation offset is at the end of file.
  */
 static int
 xfs_bmap_btalloc_at_eof(
 	struct xfs_bmalloca	*ap,
-	struct xfs_alloc_arg	*args,
-	xfs_extlen_t		blen,
-	bool			ag_only)
+	struct xfs_alloc_arg	*args)
 {
 	struct xfs_mount	*mp = args->mp;
 	struct xfs_perag	*caller_pag = args->pag;
+	xfs_extlen_t		alignment = args->alignment;
 	int			error;
 
+	ASSERT(ap->aeof && ap->offset);
+	ASSERT(args->alignment >= 1);
+
 	/*
-	 * If there are already extents in the file, try an exact EOF block
-	 * allocation to extend the file as a contiguous extent. If that fails,
-	 * or it's the first allocation in a file, just try for a stripe aligned
-	 * allocation.
+	 * Compute the alignment slop for the fallback path so we ensure
+	 * we account for the potential alignemnt space required by the
+	 * fallback paths before we modify the AGF and AGFL here.
 	 */
-	if (ap->offset) {
-		xfs_extlen_t	alignment = args->alignment;
-
-		/*
-		 * Compute the alignment slop for the fallback path so we ensure
-		 * we account for the potential alignemnt space required by the
-		 * fallback paths before we modify the AGF and AGFL here.
-		 */
-		args->alignment = 1;
-		args->alignslop = alignment - args->alignment;
-
-		if (!caller_pag)
-			args->pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, ap->blkno));
-		error = xfs_alloc_vextent_exact_bno(args, ap->blkno);
-		if (!caller_pag) {
-			xfs_perag_put(args->pag);
-			args->pag = NULL;
-		}
-		if (error)
-			return error;
-
-		if (args->fsbno != NULLFSBLOCK)
-			return 0;
-		/*
-		 * Exact allocation failed. Reset to try an aligned allocation
-		 * according to the original allocation specification.
-		 */
-		args->alignment = alignment;
-		args->alignslop = 0;
-	}
+	args->alignment = 1;
+	args->alignslop = alignment - args->alignment;
 
-	if (ag_only) {
-		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
-	} else {
+	if (!caller_pag)
+		args->pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, ap->blkno));
+	error = xfs_alloc_vextent_exact_bno(args, ap->blkno);
+	if (!caller_pag) {
+		xfs_perag_put(args->pag);
 		args->pag = NULL;
-		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
-		ASSERT(args->pag == NULL);
-		args->pag = caller_pag;
 	}
-	if (error)
-		return error;
 
-	if (args->fsbno != NULLFSBLOCK)
-		return 0;
-
-	/*
-	 * Aligned allocation failed, so all fallback paths from here drop the
-	 * start alignment requirement as we know it will not succeed.
-	 */
-	args->alignment = 1;
-	return 0;
+	/* Reset alignment to original specifications.  */
+	args->alignment = alignment;
+	args->alignslop = 0;
+	return error;
 }
 
 /*
@@ -3688,12 +3649,19 @@ xfs_bmap_btalloc_filestreams(
 	}
 
 	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
-	if (ap->aeof)
-		error = xfs_bmap_btalloc_at_eof(ap, args, blen, true);
+	if (ap->aeof && ap->offset)
+		error = xfs_bmap_btalloc_at_eof(ap, args);
 
+	/* This may be an aligned allocation attempt. */
 	if (!error && args->fsbno == NULLFSBLOCK)
 		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
 
+	/* Attempt non-aligned allocation if we haven't already. */
+	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
+		args->alignment = 1;
+		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
+	}
+
 out_low_space:
 	/*
 	 * We are now done with the perag reference for the filestreams
@@ -3715,7 +3683,6 @@ xfs_bmap_btalloc_best_length(
 	struct xfs_bmalloca	*ap,
 	struct xfs_alloc_arg	*args)
 {
-	xfs_extlen_t		blen = 0;
 	int			error;
 
 	ap->blkno = XFS_INO_TO_FSB(args->mp, ap->ip->i_ino);
@@ -3726,23 +3693,33 @@ xfs_bmap_btalloc_best_length(
 	 * the request.  If one isn't found, then adjust the minimum allocation
 	 * size to the largest space found.
 	 */
-	error = xfs_bmap_btalloc_select_lengths(ap, args, &blen);
+	error = xfs_bmap_btalloc_select_lengths(ap, args);
 	if (error)
 		return error;
 
 	/*
-	 * Don't attempt optimal EOF allocation if previous allocations barely
-	 * succeeded due to being near ENOSPC. It is highly unlikely we'll get
-	 * optimal or even aligned allocations in this case, so don't waste time
-	 * trying.
+	 * If we are in low space mode, then optimal allocation will fail so
+	 * prepare for minimal allocation and run the low space algorithm
+	 * immediately.
 	 */
-	if (ap->aeof && !(ap->tp->t_flags & XFS_TRANS_LOWMODE)) {
-		error = xfs_bmap_btalloc_at_eof(ap, args, blen, false);
-		if (error || args->fsbno != NULLFSBLOCK)
-			return error;
+	if (ap->tp->t_flags & XFS_TRANS_LOWMODE) {
+		ASSERT(args->fsbno == NULLFSBLOCK);
+		return xfs_bmap_btalloc_low_space(ap, args);
+	}
+
+	if (ap->aeof && ap->offset)
+		error = xfs_bmap_btalloc_at_eof(ap, args);
+
+	/* This may be an aligned allocation attempt. */
+	if (!error && args->fsbno == NULLFSBLOCK)
+		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
+
+	/* Attempt non-aligned allocation if we haven't already. */
+	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
+		args->alignment = 1;
+		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
 	}
 
-	error = xfs_alloc_vextent_start_ag(args, ap->blkno);
 	if (error || args->fsbno != NULLFSBLOCK)
 		return error;
 
diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 9f71a9a3a65e..40a2daeea712 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -780,7 +780,7 @@ xfs_ialloc_ag_alloc(
 		 * the exact agbno requirement and increase the alignment
 		 * instead. It is critical that the total size of the request
 		 * (len + alignment + slop) does not increase from this point
-		 * on, so reset minalignslop to ensure it is not included in
+		 * on, so reset alignslop to ensure it is not included in
 		 * subsequent requests.
 		 */
 		args.alignslop = 0;
-- 
2.31.1

