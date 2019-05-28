Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CCD2BFD0
	for <lists+linux-erofs@lfdr.de>; Tue, 28 May 2019 09:00:01 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Cl8Z4FWszDqWy
	for <lists+linux-erofs@lfdr.de>; Tue, 28 May 2019 16:59:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=141.146.126.79; helo=aserp2130.oracle.com;
 envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="lR4HFSrR"; 
 dkim-atps=neutral
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Cl8800hMzDqW1
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 May 2019 16:59:35 +1000 (AEST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4S6wsWV045880;
 Tue, 28 May 2019 06:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=tZAX3OSSOn0wbgFIM+YoGaSl2A5m+BXr7W4j+it+KCA=;
 b=lR4HFSrRAJpJgeClHkslNPlFVXCp8cMEetM4b6S6kl2urid3xZfKtkw14p3f4KKAQqDy
 1V/TEtj31Pkr+tP9KYYJXbsvd5Ore+HnjsPrp3B7B7ne+ZZ1kUuNaxDugIHF2irw+ugl
 VQKz5x6f5VWpWmLbQaSPwZ2S8iG1/Vw0pQcO/LYXYi//tPdzp0fAee/UUyZBMg6e652V
 A4PHm6wuOndjNnDO8W8UthvgG7iFu+chOQTkDkshGjVSPh6AXLn6SKxPoB0KXrz4Enaf
 sNGGaeOo20MIeS8flmyn4a7RbG2rq2DB8c8LssEpoZJWVWlAOOR5FPVIsYdc5JvDg/JJ og== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2130.oracle.com with ESMTP id 2spu7d940m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 May 2019 06:59:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4S6uMMc119906;
 Tue, 28 May 2019 06:57:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2sqh72xjfu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 May 2019 06:57:18 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4S6vHWp018798;
 Tue, 28 May 2019 06:57:17 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 27 May 2019 23:57:17 -0700
Date: Tue, 28 May 2019 09:57:09 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2 2/2] staging: erofs: fix i_blocks calculation
Message-ID: <20190528065709.GY31203@kadam>
References: <20190528023147.94117-2-gaoxiang25@huawei.com>
 <20190528023602.178923-1-gaoxiang25@huawei.com>
 <fe0ff7bb-b576-f949-d57a-2892d116b22f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe0ff7bb-b576-f949-d57a-2892d116b22f@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905280046
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905280047
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 weidu.du@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, May 28, 2019 at 11:02:12AM +0800, Chao Yu wrote:
> On 2019/5/28 10:36, Gao Xiang wrote:
> > For compressed files, i_blocks should not be calculated
> > by using i_size. i_u.compressed_blocks is used instead.
> > 
> > In addition, i_blocks was miscalculated for non-compressed
> > files previously, fix it as well.
> > 
> > Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> > ---
> > change log v2:
> >  - fix description in commit message
> >  - fix to 'inode->i_blocks = nblks << LOG_SECTORS_PER_BLOCK'
> > 
> > Thanks,
> > Gao Xiang
> > 
> >  drivers/staging/erofs/inode.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
> > index 8da144943ed6..6e67e018784e 100644
> > --- a/drivers/staging/erofs/inode.c
> > +++ b/drivers/staging/erofs/inode.c
> > @@ -20,6 +20,7 @@ static int read_inode(struct inode *inode, void *data)
> >  	struct erofs_vnode *vi = EROFS_V(inode);
> >  	struct erofs_inode_v1 *v1 = data;
> >  	const unsigned int advise = le16_to_cpu(v1->i_advise);
> > +	erofs_blk_t nblks = 0;
> >  
> >  	vi->data_mapping_mode = __inode_data_mapping(advise);
> >  
> > @@ -60,6 +61,10 @@ static int read_inode(struct inode *inode, void *data)
> >  			le32_to_cpu(v2->i_ctime_nsec);
> >  
> >  		inode->i_size = le64_to_cpu(v2->i_size);
> > +
> > +		/* total blocks for compressed files */
> > +		if (vi->data_mapping_mode == EROFS_INODE_LAYOUT_COMPRESSION)
> > +			nblks = v2->i_u.compressed_blocks;
> 
> Xiang,
> 
> It needs to use le32_to_cpu(). ;)
> 

I wonder it the kbuild bot is going to send an email about that...
Hopefully these sorts of bugs get detected with Sparse CF=-D__CHECK_ENDIAN__

regards,
dan carpenter

