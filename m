Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 7634FA3B1B
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 17:57:18 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Kkd74dJXzDr3F
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2019 01:57:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.189; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Kkd24mtBzDr0R
 for <linux-erofs@lists.ozlabs.org>; Sat, 31 Aug 2019 01:57:09 +1000 (AEST)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 4AEDDD2F06A7CCCE3201;
 Fri, 30 Aug 2019 23:57:06 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 30 Aug 2019 23:57:05 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 30 Aug 2019 23:57:05 +0800
Date: Fri, 30 Aug 2019 23:56:17 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 2/7] erofs: some marcos are much more readable as a
 function
Message-ID: <20190830155617.GB69026@architecture4>
References: <20190830030040.10599-1-gaoxiang25@huawei.com>
 <20190830030040.10599-2-gaoxiang25@huawei.com>
 <5b2ecf5cec1a6aa3834e9af41886a7fcb18ae86a.camel@perches.com>
 <20190830154551.GA11571@infradead.org>
 <20190830155223.GA69026@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190830155223.GA69026@architecture4>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
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
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 weidu.du@huawei.com, Joe Perches <joe@perches.com>,
 Miao Xie <miaoxie@huawei.com>, Dan Carpenter <dan.carpenter@oracle.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Aug 30, 2019 at 11:52:23PM +0800, Gao Xiang wrote:
> Hi Christoph,
> 
> On Fri, Aug 30, 2019 at 08:45:51AM -0700, Christoph Hellwig wrote:
> > On Thu, Aug 29, 2019 at 08:16:27PM -0700, Joe Perches wrote:
> > > > -		sizeof(__u32) * ((__count) - 1); })
> > > > +static inline unsigned int erofs_xattr_ibody_size(__le16 d_icount)
> > > > +{
> > > > +	unsigned int icount = le16_to_cpu(d_icount);
> > > > +
> > > > +	if (!icount)
> > > > +		return 0;
> > > > +
> > > > +	return sizeof(struct erofs_xattr_ibody_header) +
> > > > +		sizeof(__u32) * (icount - 1);
> > > 
> > > Maybe use struct_size()?
> > 
> > Declaring a variable that is only used for struct_size is rather ugly.
> > But while we are nitpicking: you don't need to byteswap to check for 0,
> > so the local variable could be avoided.
> > 
> > Also what is that magic -1 for?  Normally we use that for the
> > deprecated style where a variable size array is declared using
> > varname[1], but that doesn't seem to be the case for erofs.
> 
> I have to explain more about this (sorry about my awkward English)
> here i_xattr_icount is to represent the size of xattr field of erofs, as follows:
>  0 - no xattr at all (no erofs_xattr_ibody_header)
>   _______
>  | inode |
>  |_______|
> 
>  1 - a erofs_xattr_ibody_header (12 byte) + 4-byte (shared + inline) xattrs
>  2 - a erofs_xattr_ibody_header (12 byte) + 8-byte (shared + inline) xattrs
>  ....
>  (that is the magic -1 means...)
> 
> In order to keep the number continuously, actually the content could be
>  an array of shared_xattr_id and
>  an inline xattr combination (struct erofs_xattr_entry + name + value)

...Add a word, large xattrs should use shared xattr (which save xattrs
in another area) rather than inline xattr, shared xattr stores xattr_id
just after erofs_xattr_ibody_header and before inline xattrs...

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 
