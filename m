Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BEBA2D2E
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 05:16:43 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46KPlX3PrLzF0Qh
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 13:16:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=perches.com
 (client-ip=216.40.44.170; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
Received: from smtprelay.hostedemail.com (smtprelay0170.hostedemail.com
 [216.40.44.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46KPlS275dzF0Pv
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2019 13:16:34 +1000 (AEST)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay04.hostedemail.com (Postfix) with ESMTP id 2BF0B1800EC3F;
 Fri, 30 Aug 2019 03:16:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com,
 :::::::::::::::::::::::,
 RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3876:3877:4321:4605:5007:6114:6642:10004:10400:10848:11026:11232:11658:11914:12043:12048:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21451:21627:30029:30054:30091,
 0,
 RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,
 CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none, DomainCache:0,
 MSF:not bulk, SPF:fn, MSBL:0, DNSBL:neutral, Custom_rules:0:0:0, LFtime:28,
 LUA_SUMMARY:none
X-HE-Tag: music74_8ff1e63ca7e44
X-Filterd-Recvd-Size: 2212
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com
 [23.242.196.136]) (Authenticated sender: joe@perches.com)
 by omf09.hostedemail.com (Postfix) with ESMTPA;
 Fri, 30 Aug 2019 03:16:29 +0000 (UTC)
Message-ID: <5b2ecf5cec1a6aa3834e9af41886a7fcb18ae86a.camel@perches.com>
Subject: Re: [PATCH v2 2/7] erofs: some marcos are much more readable as a
 function
From: Joe Perches <joe@perches.com>
To: Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>, Dan
 Carpenter <dan.carpenter@oracle.com>, Christoph Hellwig
 <hch@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org
Date: Thu, 29 Aug 2019 20:16:27 -0700
In-Reply-To: <20190830030040.10599-2-gaoxiang25@huawei.com>
References: <20190830030040.10599-1-gaoxiang25@huawei.com>
 <20190830030040.10599-2-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 2019-08-30 at 11:00 +0800, Gao Xiang wrote:
> As Christoph suggested [1], these marcos are much
> more readable as a function

s/marcos/macros/
.
[]
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
[]
> @@ -168,16 +168,24 @@ struct erofs_xattr_entry {
>  	char   e_name[0];       /* attribute name */
>  } __packed;
>  
> -#define ondisk_xattr_ibody_size(count)	({\
> -	u32 __count = le16_to_cpu(count); \
> -	((__count) == 0) ? 0 : \
> -	sizeof(struct erofs_xattr_ibody_header) + \
> -		sizeof(__u32) * ((__count) - 1); })
> +static inline unsigned int erofs_xattr_ibody_size(__le16 d_icount)
> +{
> +	unsigned int icount = le16_to_cpu(d_icount);
> +
> +	if (!icount)
> +		return 0;
> +
> +	return sizeof(struct erofs_xattr_ibody_header) +
> +		sizeof(__u32) * (icount - 1);

Maybe use struct_size()?

{
	struct erofs_xattr_ibody_header *ibh;
	unsigned int icount = le16_to_cpu(d_icount);

	if (!icount)
		return 0;

	return struct_size(ibh, h_shared_xattrs, icount - 1);
}

