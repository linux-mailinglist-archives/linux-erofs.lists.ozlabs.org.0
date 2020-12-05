Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B463A2CFAA4
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 09:39:07 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cp2zr07hjzDqkK
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 19:39:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=RlpaeXfV; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RlpaeXfV; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cp2zj4R77zDqj1
 for <linux-erofs@lists.ozlabs.org>; Sat,  5 Dec 2020 19:38:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607157530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4RJuCuTLTaSjcWSpJPfH2sT0oxZEfLk1+KEOFCbwmTY=;
 b=RlpaeXfVI06QQAeIPfDH9gBd9drGz49jgOBWjdf35I+TLulYuA60AYNKEw7K6qzjr0ZlRs
 HQnw0g+2FclGaSjoQpi2zUW7flwIx5L3wOxnLw5Ou6Lj5rQtZvcuAteGUaGciE6fGtjZVd
 XtoRPYA9AMrzBlw3fs25nHc8zGWP4bw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607157530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4RJuCuTLTaSjcWSpJPfH2sT0oxZEfLk1+KEOFCbwmTY=;
 b=RlpaeXfVI06QQAeIPfDH9gBd9drGz49jgOBWjdf35I+TLulYuA60AYNKEw7K6qzjr0ZlRs
 HQnw0g+2FclGaSjoQpi2zUW7flwIx5L3wOxnLw5Ou6Lj5rQtZvcuAteGUaGciE6fGtjZVd
 XtoRPYA9AMrzBlw3fs25nHc8zGWP4bw=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-66yqVZ89PfK2BTTtvC6Iog-1; Sat, 05 Dec 2020 03:38:48 -0500
X-MC-Unique: 66yqVZ89PfK2BTTtvC6Iog-1
Received: by mail-pf1-f199.google.com with SMTP id x20so5376262pfm.6
 for <linux-erofs@lists.ozlabs.org>; Sat, 05 Dec 2020 00:38:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=4RJuCuTLTaSjcWSpJPfH2sT0oxZEfLk1+KEOFCbwmTY=;
 b=ufkjXb10MxSRBkNjEMbH4T4PdW+sz1Cp4DIke/5z+lJT4ya/3EmbbUQBgR5bqpsCnS
 1gff3HrP0fd0lA2a+B4WqSZQbGeXos0yaFQ6X0ozoE3jBuq89fk+JBk6ZlM4oL1FNFHg
 HnmGeRa75LbqLdhVcyLVyOX2jvciTPw5kyCyfbQtj1RjxKTT4ey6XGd8ddH3R11hRRXL
 +dqpN0E8keZSaewuifsqeC+tj0f4hkpIdZlXA+XuIepcFI/QYR/q0rYQ0vS7PyvYw9OT
 Wi+MKsLrsBBCikhCTBOXHSgoaPMiWvsZOTn2OaB47nF/7wBh85EQz9mQWQ8RBQ2Ze5ZG
 UsLw==
X-Gm-Message-State: AOAM530PJ3uIs/a+22BygM+5/srgpxDMqSc+cQX1DfX5tamsYTp10Lkp
 Ak2ZyTcWJxVAtOwEIGq29+vCpo8KcmelzDIJeh8RSVM64iy9jqObH/mLooZhDs6griYjBedOhRY
 K+9j0Wd/w8iYcXXB+oS73YDhW
X-Received: by 2002:a17:90a:5309:: with SMTP id
 x9mr7635292pjh.98.1607157527650; 
 Sat, 05 Dec 2020 00:38:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxeWKSAi7UlOZlt8FLqDzONFyYifzaBtTWY6MVZ8nDXp1r3xnMcQOMiDFL6fvOWlG8j1R3JvQ==
X-Received: by 2002:a17:90a:5309:: with SMTP id
 x9mr7635282pjh.98.1607157527421; 
 Sat, 05 Dec 2020 00:38:47 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id s5sm4588912pju.9.2020.12.05.00.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Dec 2020 00:38:47 -0800 (PST)
Date: Sat, 5 Dec 2020 16:38:37 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Li GuiFu <bluce.lee@aliyun.com>
Subject: Re: [PATCH] erofs-utils: update i_nlink stat for directories
Message-ID: <20201205083837.GA2333547@xiangao.remote.csb>
References: <20201205055732.14276-1-hsiangkao.ref@aol.com>
 <20201205055732.14276-1-hsiangkao@aol.com>
 <ed88d60a-77a9-f189-3586-a6d6aef510d9@aliyun.com>
MIME-Version: 1.0
In-Reply-To: <ed88d60a-77a9-f189-3586-a6d6aef510d9@aliyun.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Dec 05, 2020 at 04:32:44PM +0800, Li GuiFu via Linux-erofs wrote:

...

> 
> > @@ -957,6 +974,10 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
> >  			ret = PTR_ERR(d);
> >  			goto err_closedir;
> >  		}
> > +
> > +		/* to count i_nlink for directories */
> > +		d->type = (dp->d_type == DT_DIR ?
> > +			EROFS_FT_DIR : EROFS_FT_UNKNOWN);
> >  	}
> >  
> It's confused that d->type was set to EROFS_FT_UNKNOWN when not a dir
> It's not clearness whether the program goes wrong or get the wrong data
> Actually it's a correct procedure

It's just set temporarily, since only dirs are useful when counting subdirs, so
only needs to differ dirs and non-dirs here. (Previously d->type is unused
at this time.)

...

> > -		d->type = erofs_type_by_mode[d->inode->i_mode >> S_SHIFT];
> > +		ftype = erofs_mode_to_ftype(d->inode->i_mode);
> > +		DBG_BUGON(d->type != EROFS_FT_UNKNOWN && d->type != ftype);
> > +		d->type = ftype;

The real on-disk d->type will be set here rather than the above.

Thanks,
Gao Xiang

