Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91695578238
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Jul 2022 14:24:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lmh393bCdz30Qc
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Jul 2022 22:24:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=XAMBC7je;
	dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=y3fX0YEO;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oracle.com (client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=XAMBC7je;
	dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=y3fX0YEO;
	dkim-atps=neutral
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lmh326sNMz2yn3
	for <linux-erofs@lists.ozlabs.org>; Mon, 18 Jul 2022 22:23:57 +1000 (AEST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IB44GB019924;
	Mon, 18 Jul 2022 12:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=3vYT7gjFfqwQOMI9+LMKUzID/AAPhW6w8HJCyj2I6ng=;
 b=XAMBC7jeOW68FPAd9bgxugHIVJNEPQkJBgoNxBXBJVgd+8lRAD3Q5uhSszJIzSDVvoJV
 CTO0hKmGKKY5/Zp6k/lrYYNXKOPfiKJYBFMwxw4H8oCTbDepfZZHldFNbZ2uQcmACY55
 sK9uhMIxkYo3ttPtJYVihbAWvCFIRvnH+AJmU+Y2w48ueta32c1ERPgNtBQSWSBJT1cq
 5efHgYm1rhqvmfUZG8gcRP6UK4Nfu5o3E4L3v5SZ9pJQeKEaLyckWE/XKeBS6q4f4idl
 ToE5sWtj2aDFbHflG3kowVHwN4r1XFz7NUpjKfYA2GOUilJPIs5GSg8lMUQPA9s33cKJ rA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtb2wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Jul 2022 12:23:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26IBAX7c001310;
	Mon, 18 Jul 2022 12:23:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k2e367-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Jul 2022 12:23:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qgat4JVpm9AcsL5Heajfxs4FjeZ9+GGH7df+vT9rfAonfti1dfA7286uPms+DdHL0lwKNH1Hh7yoYcKp+JbCDSCZgD5Q3xEZTGgwGcbVICzA8tYONV0q4vjE4pgll1dpZ3cuEqq0p6eAfwe4RXoRDfvkA9Y9n1qxzdSB5bqg1G297IyhiGqFTSQ8mDrekpgEvFrHLOFTCWl3YoJKID11XxTOKvPr7Kqi3zNueIQephZsXZXHFWChEg1/xvtmGgz87SiE7KYR2VEXoaRrubPdP5AfFMCZ0D9iavZICLg/RlQ7UGIOv7zFJxTqvngNO7tphhPyiUsOhjfrjsDl1V7IYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vYT7gjFfqwQOMI9+LMKUzID/AAPhW6w8HJCyj2I6ng=;
 b=YqPnZFD8gP1zIrQKiSYyoPWo2vSjS1UbjBYQpD3vDg8YguGHYygvW9n1WtOvB6eAXLzReRo3jJ0t5gObwbwwoMzL192zGZK0sCXOnzA3aLpiVDWRSGU5Uh9cd7NjK85i/RQ6UskLxUrZYdEoWXbC+QgrPE8TUmpvaBKlsU8FH8ipZ7YxlrBWtgVAKFkZ44m+7W0pKpdTA53AlILlr/kU72oiLvxSYz8kJAVxx3WFRrkfir56B/Ebh0hgqNprH1K8HnEcYinT+MNG7VAidGaScrXUgKtCdDM/CjNLH+Vefa6ymNT1kPEsVweSYxluKCBpTzRc2bxMLveYS7NsoyoItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vYT7gjFfqwQOMI9+LMKUzID/AAPhW6w8HJCyj2I6ng=;
 b=y3fX0YEOQ0qvnrSd4KhlNomKvKU70gYA8JYaSz8P0UxC+ecnzUgrwsGkIfo1Jxa00YAgdwQX3uZC2IVYaTx0kYo3fzPTsz+H4OGjfi1XI7G+7Pc7pdDHzsdadSVwaoGjJARqCrc+7U92C07oq+J5IQTBUmGU8eK5coZwcVFi5oE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB3959.namprd10.prod.outlook.com
 (2603:10b6:610:d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Mon, 18 Jul
 2022 12:23:23 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 12:23:23 +0000
Date: Mon, 18 Jul 2022 15:23:13 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: clean up a loop
Message-ID: <20220718122313.GX2316@kadam>
References: <YtVB6GBWHVSc6fbU@kili>
 <YtVFrpFdaR2Iwf2x@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtVFrpFdaR2Iwf2x@B-P7TQMD6M-0146.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0057.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d85d3f3-2b08-4ca3-f790-08da68b84f06
X-MS-TrafficTypeDiagnostic: CH2PR10MB3959:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	qyf3iOmyvWc66xEoo2h3FHsulEID2IE39bJ5LlPtqB0c/iKKtGVVpze0NKpjyAOA7Wd/8H704tx828NzPMSWrLnz2HbftXes+ps+wM+zLSOBMpYH/uFjlAKjo02dZPk7LR1/atm84L/LpBmCvsPQlRhHhXnlRCgmYJ5Di9PBP6IVY+FobV1ojeNEhxp0p/VoU4iwHuV1Z/9mN06TW+1q7YV5omtMkncZv8SmbXpHPmn33ElS8z+xxBgMbOwxr5XDttqonN1cA5Q2Ck5NOu1A33vLLWyjSi4XFZokYL5sznSMQcUsjIy25nN9KQnVfVInmSklFvZVBJW1G/lMMyhhB/IPEisfEvsk4w7cplpC2WQIdWMfAGPjm89ljNlyBgXtMZ+EdmtMpmmJUxZHJ/fpzTggWV4ik5TPNb8QMV0/rHGpWEueximI+v0znKGkKeXErwChXRJX7hpeSj5+V9Up17AHN3NlXQfgSVExGRfWesja+HIxHPjs0BOrj+PaV8QsULcOKoKAb4CGQ7yAfvDGv6lXgbAsJHd1Cpuml40BSkSLhce4kbLxTVVgoE9hyp5UpCTR6aYwZoGcjpEU4+TyJj7odWHAlXLa1nKct94hYDoxdXLqFTlbwd89TE8KtVZZU6ONhPlPQv3oNPIcpbgtw4UreVGqO2kUejdCaro0ikavjKChLTjIxIEQVquQH1OxyhiRpvu50KOPmfuLN26JliXIndVnOpJdNmkHy+sXqM385e0/Gt5MLuhvD/nvbYpDFAw3kONlegKPxTvg2R6kAp36mxXwwFyhRB/q2Tr8OnWpsPpmu1ZOdMphAaqGbdB7
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(376002)(366004)(396003)(346002)(39860400002)(83380400001)(6486002)(478600001)(38350700002)(6666004)(41300700001)(6506007)(6512007)(38100700002)(316002)(1076003)(186003)(6916009)(52116002)(8676002)(44832011)(66946007)(5660300002)(8936002)(66556008)(4326008)(66476007)(86362001)(54906003)(33656002)(26005)(2906002)(9686003)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?XlP0nrPh3q2Ty+Mn81sbzWs2t6FbrcAG/uIzQCjzv/HdIElDzmjvg955pXlZ?=
 =?us-ascii?Q?HlDfLfMBpr32TDeqcaDdPwR4Y3GB5zOxHmUaAQ7c6yQWbXlEYokzhlt4PKu2?=
 =?us-ascii?Q?olcU7HhBwyWwmx5aTeVgPcR2HrWRw9YHBs+ZtiKdgLeTadrptY8wpVajhDfB?=
 =?us-ascii?Q?97wyAd2bMaeQQxou/NSgl2qt/AG7QaGSJoE/rL0yuPRfglwsPsFj/cREZTJr?=
 =?us-ascii?Q?6t8FImsWh+yVtmHviTrf3XDOF4zEBSBi8DjXb71vm07uVvxCWTca/Tkuvs09?=
 =?us-ascii?Q?lZzJnTR7aNoX0Y8/P2vwGlZ+2HihqeO6kPLTH+dsNV1Ye9nFXqZjIdQbAWhv?=
 =?us-ascii?Q?yJKcOYGRgu4yJuu/Tu9buKI50h8YMfDo7nyCgsnvmfYxlvkEdL4hPFOlXScg?=
 =?us-ascii?Q?5anSCDyae0AInSHEmslr0YfEPd5lpi7c8vFjdO98uRRgQC6C28dQ0bo0mdOq?=
 =?us-ascii?Q?AY/FPRlG9bP0yTmKOpRbiQeQ/op0etxHqf5Av39xIcciSuxoZVmjHpSBLpL1?=
 =?us-ascii?Q?aKXTFn5ZTIEQxyzEV+yKRKrhVzKnMBWpeMQe2Dlw6IWgiM623LTXWIq9MDjn?=
 =?us-ascii?Q?c5v/xenZKQqKKFH5MOKE5HQ/DnwWoRdJMVwW7fuyafSdbY3o+3wu64a+5tw5?=
 =?us-ascii?Q?DCXmqIkeC7ZQlP0At5hNzkFUMumVOTU2Y6yAkP0IR1KzWCO2FB7H/QdP0uZA?=
 =?us-ascii?Q?pxCPBL3skA5dyKTXFJ32otoOsxgiROQaQv5UVIixzB2bRLcrQKxYi8RZJKhS?=
 =?us-ascii?Q?fMmj6O+0pobnFnH02xUFFu556A822DLbM65sMxKYQXPDIYKo91FHnGRU+BcF?=
 =?us-ascii?Q?6wlRauCzkGqc2unS3szxyaim6Fm5Gluir0cfk4+E290eTATjqoJqt17AnjCI?=
 =?us-ascii?Q?jiaHHRlJoOPdBrXFKoAs36/SEWGvlmCpzwFfvqqmtNwJmke5fENLixFRS0M2?=
 =?us-ascii?Q?esRuE41c8b8nvnO3WlHaazdngQ6OJEhgfRNL5WbxJjdhjq2rZ1D2c728zCeV?=
 =?us-ascii?Q?2fW49zZdTAHYzpN+GTQDMXz27YzTBX5vsr6OV2mEJXx6yeqOBQuJhJBiqg/Q?=
 =?us-ascii?Q?zmalqK+jHOkD23iRQRSWK+mMu+OpLDVNRcErpLD7cBz9/a+TK5EqkITuBn2I?=
 =?us-ascii?Q?obHb5YURfxWPB24dhiTPKhmgU9JS8mpSCdXItftX59ZD8eeWR1MUXjAEG/lt?=
 =?us-ascii?Q?tczfhkkjSabBCZldLdDgsJ4iZ1zgQ/huJCU78b1bHVOZlSae3vqh/qe13xqq?=
 =?us-ascii?Q?HkYTJPVH1OXWEC0M2btxprG12avaF95nEvoJS4as/r/3bI6s05Y4Zjib9kPa?=
 =?us-ascii?Q?kFrQGksURBCUjWb498Aon4pCVYev5iMHhHZCt75B9G/jHTW/Ze9NR3wwlN91?=
 =?us-ascii?Q?YqZi3ysTznoLWGrkw8jjtlefsJhYe9ouNNBb+tEpx3OEKcjl4XGVrDU5J742?=
 =?us-ascii?Q?+Zqod9YZBmffZN9ug0LKkJA47V8MYbP59NO69CX3CSi9/lIrLmgD1zJrsIj9?=
 =?us-ascii?Q?NvJ6TWPFwHH/KbEz+I8R7EYhVTKMtqQEFjCkMiNkqeMTRU4+Jh+zjcVw8o4+?=
 =?us-ascii?Q?zHMQwT2xnunuP2VEAc0RZHi5TFxcsj2UxoJpDrEVZCpkofPp8GTqqSmkMcdf?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d85d3f3-2b08-4ca3-f790-08da68b84f06
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 12:23:23.7661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eviY+ZkvUPft5V2WoyBQlu6fDt1qcb4vVRcBa8/AGNZ0KKYZ9BYSfTfRVBubEFzyeEuoiRBSq3qiSG/5u7vaUwOg5PvtshdUusgRGn2Zyr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3959
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_11,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180053
X-Proofpoint-GUID: qii-hEdKztAHGHJxD-p5t9T11d00oFOB
X-Proofpoint-ORIG-GUID: qii-hEdKztAHGHJxD-p5t9T11d00oFOB
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
Cc: kernel-janitors@vger.kernel.org, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 18, 2022 at 07:36:14PM +0800, Gao Xiang wrote:
> Hi Dan,
> 
> On Mon, Jul 18, 2022 at 02:20:08PM +0300, Dan Carpenter wrote:
> > It's easier to see what this loop is doing when the decrement is in
> > the normal place.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  fs/erofs/zdata.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> > index 601cfcb07c50..2691100eb231 100644
> > --- a/fs/erofs/zdata.c
> > +++ b/fs/erofs/zdata.c
> > @@ -419,8 +419,8 @@ static bool z_erofs_try_inplace_io(struct z_erofs_decompress_frontend *fe,
> >  {
> >  	struct z_erofs_pcluster *const pcl = fe->pcl;
> >  
> > -	while (fe->icur > 0) {
> > -		if (!cmpxchg(&pcl->compressed_bvecs[--fe->icur].page,
> > +	while (fe->icur--) {
> 
> Thanks for your patch!
> Yet at a quick glance, on my side, that doesn't equal
> to be honest...
> 
> .. What we're trying to do here is to find a free slot
> for inplace i/o, but also need to leave fe->icur as 0
> when going out the loop since z_erofs_try_inplace_io()
> can be called again the next time when attaching
> another page but it will overflow then...

Ah.  Sorry.  I never thought about it being called twice in a row.

regards,
dan carpenter

