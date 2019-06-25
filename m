Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 6143A52816
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jun 2019 11:29:35 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Y18D5t5YzDqNn
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jun 2019 19:29:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="GXkWswWX"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Y1893rzvzDqMW
 for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jun 2019 19:29:29 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id y15so4534091pfn.5
 for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jun 2019 02:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pVj0pC3MqA7YS3pcfCUYvetCdTpWf7DA4pKCUULfv28=;
 b=GXkWswWX1zG6ceLHkFNP5w3s/fYYX+XIghYd//7gNq/eKQSXbJRcn472reyyIGdlT3
 Dvi8ogFn+EM+Co/Wga5ZApTcnGhd8hvjO5BemCrfxox8uluahijr7B9AyQTH1+xPqNpo
 lNBEVryN0C+nbId0J4CGawM5HRGnGPcVaai4wR+eznyRnrtpYotr3755SpowLbaFLcH3
 2GgTGGZpeBjG7Lo1oLZTlAYm5qipL9o9t/VUNbZl8RNUrEJbcmqOAoG/38wRf7rltL+c
 dF96KtIdLC0ERwXz7lRbeNixz/ZLkJLJu1KMh62W6k3BtNxXPzAK93VG2D0HVfFnN29s
 PfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pVj0pC3MqA7YS3pcfCUYvetCdTpWf7DA4pKCUULfv28=;
 b=S++Zc0XcZ5XU06D3V0CewdIHFVNkd9JlQHuPVEH2ZRcF//UqXpR9XOWe/FnhoEmr4x
 8giGcpPXJvbIqv6gbZBX8oLIWBQfqdkQkFtFarAFBxFdcvx3eFAIpKfCESDkJtvG8dkg
 giRTbKyDH37GdD+gMTO+MgSzWUzCVMOYs8BI1ahu425uqltIRIR4Hu14EtkV7zGHz8pR
 5w6yYu6MgXH4ryEBlZ/dT39jaRhqjtGDXfa3Mz/0PBp94XeIxqrtDBjjptbGg+UaTCNI
 MkAZs0AIkUqNhuu6gectEXetmNw2aVu7bpeu6trwxhhxq/zKwFzdhAuj9FClzu10vq0J
 QNng==
X-Gm-Message-State: APjAAAW86go6mOrWVqmF1s9aB0nYoRsnBrO1c+He0YKt+Fpm6y8DrbuB
 KY8toES2wgTAvKr/SFIvrj0=
X-Google-Smtp-Source: APXvYqw1UXRAHwH7xqlGXczbWRwJLscPeVOBRjNhjVE1hgJ5WG0O7HedxoXXkDG9PKbIkLGSMjUhrg==
X-Received: by 2002:a17:90a:730b:: with SMTP id
 m11mr30519045pjk.89.1561454965926; 
 Tue, 25 Jun 2019 02:29:25 -0700 (PDT)
Received: from localhost ([218.189.10.173])
 by smtp.gmail.com with ESMTPSA id i3sm15580904pfo.138.2019.06.25.02.29.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 25 Jun 2019 02:29:25 -0700 (PDT)
Date: Tue, 25 Jun 2019 17:29:12 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [PATCH] staging: erofs: return the error value if
 fill_inline_data() fails
Message-ID: <20190625172912.00002d55.zbestahu@gmail.com>
In-Reply-To: <b724c331-5338-d827-6618-1bded956c41d@aol.com>
References: <20190625075943.2420-1-zbestahu@gmail.com>
 <b724c331-5338-d827-6618-1bded956c41d@aol.com>
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
Cc: linux-erofs@lists.ozlabs.org, gregkh@linuxfoundation.org, huyue2@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 25 Jun 2019 17:19:36 +0800
Gao Xiang <hsiangkao@aol.com> wrote:

> On 2019/6/25 ????3:59, Yue Hu Wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > We should consider the error returned by fill_inline_data() when filling
> > last page in fill_inode(). If not getting inode will be successful even
> > though last page is bad. That is illogical. Also change -EAGAIN to 0 in
> > fill_inline_data() to stand for successful filling.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>  
> 
> looks good to me, yet I think you need to Cc staging mailing list at
> least if you want to upstream quickly (including your older patches...)
> 
> 
> Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
> 
> 
> (Don't forget to add 'PATCH RESEND' tag at the subject line if you
> resend these patches.)

Ok, got it.

Thx.

> 
> Thanks,
> Gao Xiang
> 
> 
> > ---
> >  drivers/staging/erofs/inode.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
> > index d6e1e16..1433f25 100644
> > --- a/drivers/staging/erofs/inode.c
> > +++ b/drivers/staging/erofs/inode.c
> > @@ -156,7 +156,7 @@ static int fill_inline_data(struct inode *inode, void *data,
> >  		inode->i_link = lnk;
> >  		set_inode_fast_symlink(inode);
> >  	}
> > -	return -EAGAIN;
> > +	return 0;
> >  }
> >  
> >  static int fill_inode(struct inode *inode, int isdir)
> > @@ -223,7 +223,7 @@ static int fill_inode(struct inode *inode, int isdir)
> >  		inode->i_mapping->a_ops = &erofs_raw_access_aops;
> >  
> >  		/* fill last page if inline data is available */
> > -		fill_inline_data(inode, data, ofs);
> > +		err = fill_inline_data(inode, data, ofs);
> >  	}
> >  
> >  out_unlock:
> >   

