Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FACAA2D3F
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 05:21:07 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46KPrc3RnnzF0QS
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 13:21:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.187; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46KPrX0Z1czF0Pv
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2019 13:20:58 +1000 (AEST)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id C63AB9F8AE0403F8D5D2;
 Fri, 30 Aug 2019 11:20:54 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 30 Aug 2019 11:20:54 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 30 Aug 2019 11:20:53 +0800
Date: Fri, 30 Aug 2019 11:20:06 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 2/7] erofs: some marcos are much more readable as a
 function
Message-ID: <20190830032006.GA20217@architecture4>
References: <20190830030040.10599-1-gaoxiang25@huawei.com>
 <20190830030040.10599-2-gaoxiang25@huawei.com>
 <5b2ecf5cec1a6aa3834e9af41886a7fcb18ae86a.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5b2ecf5cec1a6aa3834e9af41886a7fcb18ae86a.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme712-chm.china.huawei.com (10.1.199.108) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
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
 Christoph Hellwig <hch@infradead.org>, weidu.du@huawei.com,
 linux-erofs@lists.ozlabs.org, Dan Carpenter <dan.carpenter@oracle.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Joe,

On Thu, Aug 29, 2019 at 08:16:27PM -0700, Joe Perches wrote:
> On Fri, 2019-08-30 at 11:00 +0800, Gao Xiang wrote:
> > As Christoph suggested [1], these marcos are much
> > more readable as a function
> 
> s/marcos/macros/
> .
> []
> > diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> []
> > @@ -168,16 +168,24 @@ struct erofs_xattr_entry {
> >  	char   e_name[0];       /* attribute name */
> >  } __packed;
> >  
> > -#define ondisk_xattr_ibody_size(count)	({\
> > -	u32 __count = le16_to_cpu(count); \
> > -	((__count) == 0) ? 0 : \
> > -	sizeof(struct erofs_xattr_ibody_header) + \
> > -		sizeof(__u32) * ((__count) - 1); })
> > +static inline unsigned int erofs_xattr_ibody_size(__le16 d_icount)
> > +{
> > +	unsigned int icount = le16_to_cpu(d_icount);
> > +
> > +	if (!icount)
> > +		return 0;
> > +
> > +	return sizeof(struct erofs_xattr_ibody_header) +
> > +		sizeof(__u32) * (icount - 1);
> 
> Maybe use struct_size()?
> 
> {
> 	struct erofs_xattr_ibody_header *ibh;
> 	unsigned int icount = le16_to_cpu(d_icount);
> 
> 	if (!icount)
> 		return 0;
> 
> 	return struct_size(ibh, h_shared_xattrs, icount - 1);
> }

Okay, That is fine, will resend this patch.

Thanks,
Gao Xiang

> 
