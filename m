Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96F9435E4B
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Oct 2021 11:50:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HZjQm2mkpz305Z
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Oct 2021 20:50:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HZjQc43l5z2ynK
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Oct 2021 20:50:30 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R831e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0Ut82EPd_1634809812; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Ut82EPd_1634809812) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 21 Oct 2021 17:50:13 +0800
Date: Thu, 21 Oct 2021 17:50:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH] erofs-utils: sort shared xattr
Message-ID: <YXE30+2qU75+0szk@B-P7TQMD6M-0146.local>
References: <20211021025847.1136-1-huangjianan@oppo.com>
 <20211021025847.1136-2-huangjianan@oppo.com>
 <YXEV/e/lGn4S5fym@B-P7TQMD6M-0146.local>
 <e88f1baf-b82f-cea8-d75b-b13fb2e33849@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e88f1baf-b82f-cea8-d75b-b13fb2e33849@oppo.com>
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
Cc: yh@oppo.com, guoweichao@oppo.com, linux-erofs@lists.ozlabs.org,
 zhangshiming@oppo.com, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Oct 21, 2021 at 05:28:25PM +0800, Huang Jianan wrote:
> 
> 
> 在 2021/10/21 15:25, Gao Xiang 写道:
> > Hi Jianan,
> > 
> > On Thu, Oct 21, 2021 at 10:58:47AM +0800, Huang Jianan via Linux-erofs wrote:
> > > Sort shared xattr before writing to disk to ensure the consistency
> > > of reproducible builds.
> > How about adding it as an option?
> 
> Can we consider turning on this by default abd add some test cases to ensure
> that xattr
> functionality?  It seems that this part of the modification has no effect on
> the overall
> function.

Ok, that is fine with me as well.

> 
> > > ---
> > >   lib/xattr.c | 34 ++++++++++++++++++++++++++++++----
> > >   1 file changed, 30 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/lib/xattr.c b/lib/xattr.c
> > > index 196133a..f17e57e 100644
> > > --- a/lib/xattr.c
> > > +++ b/lib/xattr.c
> > > @@ -171,7 +171,7 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
> > >   	/* allocate key-value buffer */
> > >   	len[0] = keylen - prefixlen;
> > > -	kvbuf = malloc(len[0] + len[1]);
> > > +	kvbuf = malloc(len[0] + len[1] + 1);
> > >   	if (!kvbuf)
> > >   		return ERR_PTR(-ENOMEM);
> > >   	memcpy(kvbuf, key + prefixlen, len[0]);
> > > @@ -196,6 +196,7 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
> > >   			len[1] = ret;
> > >   		}
> > >   	}
> > > +	kvbuf[len[0] + len[1]] = '\0';
> > >   	return get_xattritem(prefix, kvbuf, len);
> > >   }
> > > @@ -398,7 +399,7 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
> > >   	len[0] = sizeof("capability") - 1;
> > >   	len[1] = sizeof(caps);
> > > -	kvbuf = malloc(len[0] + len[1]);
> > > +	kvbuf = malloc(len[0] + len[1] + 1);
> > >   	if (!kvbuf)
> > >   		return -ENOMEM;
> > > @@ -409,6 +410,7 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
> > >   	caps.data[1].permitted = (u32) (capabilities >> 32);
> > >   	caps.data[1].inheritable = 0;
> > >   	memcpy(kvbuf + len[0], &caps, len[1]);
> > > +	kvbuf[len[0] + len[1]] = '\0';
> > >   	item = get_xattritem(EROFS_XATTR_INDEX_SECURITY, kvbuf, len);
> > >   	if (IS_ERR(item))
> > > @@ -562,13 +564,23 @@ static struct erofs_bhops erofs_write_shared_xattrs_bhops = {
> > >   	.flush = erofs_bh_flush_write_shared_xattrs,
> > >   };
> > > +static int comp_xattr_item(const void *a, const void *b)
> > > +{
> > > +	const struct xattr_item *ia, *ib;
> > > +
> > > +	ia = (*((const struct inode_xattr_node **)a))->item;
> > > +	ib = (*((const struct inode_xattr_node **)b))->item;
> > > +
> > > +	return strcmp(ia->kvbuf, ib->kvbuf);
> > could we use strncmp (len[0] + len[1]) instead?
> 
> It seems that strncmp can't guarantee the order since ia and ib has
> different len. We
> have ensure kvbuf[len[0] + len[1]] = '\0', Is there anything else to
> consider?

you could min(xa, xb) and strncmp first. If strncmp returns 0, compare
length then.

Thanks,
Gao Xiang

> 
> Thanks,
> Jianan
> 
> > Thanks,
> > Gao Xiang
