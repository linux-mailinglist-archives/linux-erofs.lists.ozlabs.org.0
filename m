Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BA47E4D5CB1
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 08:49:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KFJ454kyxz2yyf
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 18:49:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=I+MNjb3C;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033;
 helo=mail-pj1-x1033.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=I+MNjb3C; dkim-atps=neutral
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KFJ3z40mYz2xXX
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Mar 2022 18:49:33 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id
 m11-20020a17090a7f8b00b001beef6143a8so7459603pjl.4
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Mar 2022 23:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UzP5nyGsG5GcBeZpseFrZjEpwCJXFyPvLwGQvRUfnNo=;
 b=I+MNjb3CDGdWqP0vN8lxP24xDaRT2FsDjXqHEF8anMTchEqnJESHsAJ5VSU3coSSh+
 UZTErUAkeAAjATqg/sexMBi4kvDDB3kcFgReh8VQTfrL0lRESjd2BykhwR3FJOA1yNhO
 wlNDdrP78dFszJNYudc8oOTvgCfj1r6NOtjNYyjbX7DY22XC9+62V6xgbiYbZVYlzq/S
 PxcHJBvwZfy9iWVhodI/6rsEKS+xDy/lsu0v3uGeJHXr9ozgn9FSGdCjRVcrfg2We15x
 w9hxuSnTMiECb92PKg2M9mpJiNpZUtDvBeU+ING2wAgQuFPPRo9QN5Haa4YP1vKpxX/W
 PbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UzP5nyGsG5GcBeZpseFrZjEpwCJXFyPvLwGQvRUfnNo=;
 b=rGuwm97weCZXZO82VwrX/4uTGX19OJWE2nn2bBG+ycLvqnNZL7P7jsr7bjWR52cD7H
 9QvIcWYZra10QiHhpgy5t3B+mW0qLu8O9rNbYAOXZllVXrOtplQZVuPtZ6K50eO+KPd+
 LDmbdDbMs17VkoW33CpDDwUsCkC29mBo2HiOj3/nk2XWq5QBFGvG4SSBFdEJ0S3+8Mun
 STY+BUI7Bei0TXr55k0rfVFP+a7/FaaKW+kZm0DAO2+GIAX8IeCmIrWdFyXg1nK9p5FG
 A1raRSn+Bwy0ZsEAFy6MP9zm2sjxSAuwV5MQHdGsVjBPR7MNsMDV+dU2JO3Wew2sMNMf
 UG2g==
X-Gm-Message-State: AOAM5315oL3WNQa+KcV0vMcpeI2Wz3U3ev2Cl7/9LCt9qVAf4uKTRPEK
 j3Xe68D+Ae2Ehj+LXgajE7U=
X-Google-Smtp-Source: ABdhPJzsmRHcxa6IQeOpJXmKQsO67zzYMTHhIWp68vwt20iA/12obEHLhxXGb0uvrIXs5xnkDLJreA==
X-Received: by 2002:a17:90b:3ec8:b0:1bf:ddf:92f0 with SMTP id
 rm8-20020a17090b3ec800b001bf0ddf92f0mr9324478pjb.161.1646984969050; 
 Thu, 10 Mar 2022 23:49:29 -0800 (PST)
Received: from localhost ([103.220.76.197]) by smtp.gmail.com with ESMTPSA id
 mu1-20020a17090b388100b001bf861ef154sm12668948pjb.55.2022.03.10.23.49.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 10 Mar 2022 23:49:28 -0800 (PST)
Date: Fri, 11 Mar 2022 15:48:16 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 1/2] erofs: clean up z_erofs_extent_lookback
Message-ID: <20220311154816.00004d23.zbestahu@gmail.com>
In-Reply-To: <Yir8lBR2gyN1CJ8D@B-P7TQMD6M-0146.local>
References: <20220310182743.102365-1-hsiangkao@linux.alibaba.com>
 <20220311151232.00003619.zbestahu@gmail.com>
 <Yir6HNsdYFdLVwEN@B-P7TQMD6M-0146.local>
 <Yir8lBR2gyN1CJ8D@B-P7TQMD6M-0146.local>
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 11 Mar 2022 15:39:00 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On Fri, Mar 11, 2022 at 03:28:28PM +0800, Gao Xiang wrote:
> > On Fri, Mar 11, 2022 at 03:12:32PM +0800, Yue Hu wrote:  
> > > On Fri, 11 Mar 2022 02:27:42 +0800
> > > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > >   
> > > > Avoid the unnecessary tail recursion since it can be converted into
> > > > a loop directly in order to prevent potential stack overflow.
> > > > 
> > > > It's a pretty straightforward conversion.
> > > > 
> > > > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > > > ---
> > > >  fs/erofs/zmap.c | 67 ++++++++++++++++++++++++-------------------------
> > > >  1 file changed, 33 insertions(+), 34 deletions(-)
> > > > 
> > > > diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> > > > index b4059b9c3bac..572f0b8151ba 100644
> > > > --- a/fs/erofs/zmap.c
> > > > +++ b/fs/erofs/zmap.c
> > > > @@ -431,48 +431,47 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
> > > >  				   unsigned int lookback_distance)
> > > >  {
> > > >  	struct erofs_inode *const vi = EROFS_I(m->inode);
> > > > -	struct erofs_map_blocks *const map = m->map;
> > > >  	const unsigned int lclusterbits = vi->z_logical_clusterbits;
> > > > -	unsigned long lcn = m->lcn;
> > > > -	int err;
> > > >  
> > > > -	if (lcn < lookback_distance) {
> > > > -		erofs_err(m->inode->i_sb,
> > > > -			  "bogus lookback distance @ nid %llu", vi->nid);
> > > > -		DBG_BUGON(1);
> > > > -		return -EFSCORRUPTED;
> > > > -	}
> > > > +	while (m->lcn >= lookback_distance) {
> > > > +		unsigned long lcn = m->lcn - lookback_distance;
> > > > +		int err;  
> > > 
> > > may better to declare variable 'lclusterbits' in loop just like 'err' usage?  
> > 
> > I'm fine with either way. Ok, will post the next version later.  
> 
> Oh, I just noticed that you mean `lclusterbits', I think it won't
> change in this function, so I don't tend to move it into the inner
> loop.

Ok, looks good to me.

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> 
> Thanks,
> Gao Xiang
> 
> > 
> > Thanks,
> > Gao Xiang  

