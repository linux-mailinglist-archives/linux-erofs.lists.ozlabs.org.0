Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4830E59293
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jun 2019 06:22:53 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45ZkBy5T4GzDqpr
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jun 2019 14:22:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Za72r1rs"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Zk7q1MpNzDq9D
 for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jun 2019 14:20:06 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id a93so2484151pla.7
 for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jun 2019 21:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QMVsVsENIq5jFVBrHyEsaAKaZZYq8Ei7fMqMQWtvxsQ=;
 b=Za72r1rsgL7lhP8DM+xELMGe9NVDyDZjOKOxNxxq6eF8WPJ8VtTJmdiYTGT50kO17c
 keHsNLt1GVHL+lmFKoqnzHVNSH8HO7aSpHAeYX2c2rqzXZl36P0TTkcvQQA0OKqdNsHH
 VYNS/pktmMUG04o5AOQUBXaoWKPDZAogTLZMzd+HUZump9i3dxq24i2bnNM7HzoX55FK
 i7IGNtitAzGdKdZiLK0ZH/OXqArRHCNMmLoi6LRJPvG1Yo0XFM5JDWKt6lJJjkerHnU0
 izBhA47ziV/l+hyyNnUZdttQhcRSOOkZwK+pFrqpnxkp+14h2RsEltdhx+8i7if6W8V+
 Lqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QMVsVsENIq5jFVBrHyEsaAKaZZYq8Ei7fMqMQWtvxsQ=;
 b=N37OMQaL7kX45+8Cw6zMRTbsdOSe3VTavPFqLlUZbqkY2M6ltxEuyHw7e/Bmk3BUME
 coWR70lszIuVDgqbT+6TCgP3orOxYKdl7WpbGShzGXsNpkZyhnKyfkeWrmu1n7ivAB7b
 oS9F8pEcWkpeOUPZXKY9mzsT3hAa4PYrQ4eBI+v4B0mOMO0Sc+O2rjkrqhxfna9mGhP8
 RcMrLsZJ0zHW5TD2bBNwNuy6+2TZwHzJV+w/YJ2EFyzw0uwRB0wN2gKgcUbC5IzH9oXJ
 TxNysMviuID6Cz1Gk1PF5fykFUtNpDujg+VO16ZYIf3Rr90/xRZpsoK9b5H7peaSS70J
 GNgw==
X-Gm-Message-State: APjAAAWSLK9zH41M/VKD+L1Lixki093PWtWZ5Eksuq1a5n94DIXKpyj2
 thZr/eQyov3CcxuKrqNDnjE=
X-Google-Smtp-Source: APXvYqzAfadCUE/mQqcPjchTjuq2EteuY+sMRrt9vCSdBvZRoQaSoVSh7CehrfYUOzkMJ8HsHtc+Tg==
X-Received: by 2002:a17:902:8546:: with SMTP id
 d6mr8801004plo.207.1561695604386; 
 Thu, 27 Jun 2019 21:20:04 -0700 (PDT)
Received: from localhost ([218.189.10.173])
 by smtp.gmail.com with ESMTPSA id f10sm546776pgq.73.2019.06.27.21.20.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 27 Jun 2019 21:20:04 -0700 (PDT)
Date: Fri, 28 Jun 2019 12:19:52 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH] staging: erofs: don't check special inode layout
Message-ID: <20190628121952.000028fc.zbestahu@gmail.com>
In-Reply-To: <276837dc-b18a-6f20-fc33-d988dff5ae9f@huawei.com>
References: <20190628034234.8832-1-zbestahu@gmail.com>
 <276837dc-b18a-6f20-fc33-d988dff5ae9f@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 Miao Xie <miaoxie@huawei.com>, linux-kernel@vger.kernel.org, huyue2@yulong.com,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 28 Jun 2019 11:50:21 +0800
Gao Xiang <gaoxiang25@huawei.com> wrote:

> Hi Yue,
> 
> On 2019/6/28 11:42, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > Currently, we will check if inode layout is compression or inline if
> > the inode is special in fill_inode(). Also set ->i_mapping->a_ops for
> > it. That is pointless since the both modes won't be set for special
> > inode when creating EROFS filesystem image. So, let's avoid it.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>  
> 
> Have you test this patch with some actual image with legacy mkfs since
> new mkfs framework have not supported special inode...

Hi Xiang,

I'm studying the testing :)

However, already check the code handling for special inode in leagcy mkfs as below:

```c
                break;
        case EROFS_FT_BLKDEV:
        case EROFS_FT_CHRDEV:
        case EROFS_FT_FIFO:
        case EROFS_FT_SOCK:
                mkfs_rank_inode(d);
                break;

        default:
                erofs_err("inode[%s] file_type error =%d",
                          d->i_fullpath,
```

No special inode layout operations, so this change should be fine.

Thx.

> 
> I think that is fine in priciple, however, in case to introduce some potential
> issues, I will test this patch later. I will give a Reviewed-by tag after I tested
> this patch.

Thanks.

> 
> Thanks,
> Gao Xiang
> 
> > ---
> >  drivers/staging/erofs/inode.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
> > index 1433f25..2fe0f6d 100644
> > --- a/drivers/staging/erofs/inode.c
> > +++ b/drivers/staging/erofs/inode.c
> > @@ -205,6 +205,7 @@ static int fill_inode(struct inode *inode, int isdir)
> >  			S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
> >  			inode->i_op = &erofs_generic_iops;
> >  			init_special_inode(inode, inode->i_mode, inode->i_rdev);
> > +			goto out_unlock;
> >  		} else {
> >  			err = -EIO;
> >  			goto out_unlock;
> >   

