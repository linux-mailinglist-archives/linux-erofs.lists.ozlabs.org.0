Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E61BCA12C52
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 21:13:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1736972012;
	bh=10HfpUL4vbzTE8z3sE1cNiKFmGmMremYjdqrg8+vicQ=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=gve8nVR146KfXu4Y4QgcRsK4lXb82Qey7Nldb2Sm/t42aaKQidTQRtNJJeDMz/b+i
	 G+/Eh3/E1KTJ3TVRk+IZyJidXwruGB2NbL59DylkiNoEkO/gd3tbpMYnrg6B7Ww+DY
	 Fp2BwM+Havpaq3LWmUkayNpZXH1mbaJWdZJT4D2bA48GoRAcrK2Tra1dgcM9aZ7+Os
	 Hn/CKycJ8fnRvcKTFeSf7joGWCcViq2zQY6RJPmQ8hiKfDDOj/6uATS3Dq/SLgOvTV
	 /2wDLVJh+EaIOuGKQJzfh5vTUMkKLHAcG4fpmUMNZNw2yqVh7+ll9W6uN27NeXkf2V
	 NF7VZKyC9Fm6w==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYHHw3Q99z3bk0
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 07:13:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736972010;
	cv=none; b=aiHp+gBjoq/VaLmwO3U2/CnpR9aqpKfkmD27sY0ooJWf0X0EIPeFRsAhJVoKCcozH1psofm5zkX4z+LWs6yuZi0lB81n2jDMdY1uWYh3IJ0huh5/HIf5sOKQq8561ou/ywltN/4XtwAtAwtGPBI06C6htnP8rF43p2C5wmYGQZTjSH/iRl/UPWKCs4uqFs8wlDK2IbxO3YMxny+selrZhogmJTpBdD8jMOHxHM4q4/mT7uZDqSkhOGVi5OQ2ySrP2aUUtwHmsC2i/xU4hgdVoLQkuSugCAJHh1ztRUDcKunu5ab1sH/Qz5PRwYdZ19hJUBCpusXtc1wFEm6vQPMrCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736972010; c=relaxed/relaxed;
	bh=10HfpUL4vbzTE8z3sE1cNiKFmGmMremYjdqrg8+vicQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ap/hUi5dkQAwHWV2LUY0RsDXUBcpJzFI1n56khp6GzpP+satEC5HPpMYnNbS0q63eMKCLtTWkND/PklxqxncxxXDn59tqYC0rXxb4riaHuRvq5VWSTZH0AfZ1OHWXTyTutudpY/DXQbWZO/GRoVtefrzoNTGEn+Ax0Y1UydFQLayvt64asQFh4n16ty3xtlgktyt6680GZ8/Adw8MrJkSWu/W8SzzXrG68douMgbT8YP6XkGuyFIY0uN/T2+58Lzf4yH2Vf/DDDo+mS9xNLfxSXkMC4DHXKIjT+tIVKFiIGeHyv61DOykV5LHluleRIK+BrvrsTq05JDHb0KAlQCcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=h2UC/ylN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=david@fromorbit.com; receiver=lists.ozlabs.org) smtp.mailfrom=fromorbit.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=h2UC/ylN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=fromorbit.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=david@fromorbit.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYHHs1p6Mz30NF
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Jan 2025 07:13:28 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2163b0c09afso1785415ad.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 15 Jan 2025 12:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1736972007; x=1737576807; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=10HfpUL4vbzTE8z3sE1cNiKFmGmMremYjdqrg8+vicQ=;
        b=h2UC/ylNarm3M5XFTzSV2QwNdsm452oIw0zr9Cj54Qjw+dglDclrIbyl0qRGw5zLdu
         M11WSI+FoOxd2ThSOWtLkTiVcdE34s6bPZ7zxqi9++3E9zXf5Q3rvJYPAd/Zq8N+PePt
         WpYZhpEpaYWmGkxa2lMjlhHPMjTJJEOfc4YHRHdXs0YfyX09xskm0OJ1usi+tzRO2qJ3
         2GV4BZyDSMzSSEXh7rsEs0tGrNH4JPRBnndsLVVZ0+ZZuXA5i8kF2avlG9Hxn38gMh7t
         jMXpQ/Nd1XwLVjlbRaCEPyhJkSTmNsknvaHfNdlnGkp8TZrZ2TddP62PfPUapauqNQUn
         DLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736972007; x=1737576807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10HfpUL4vbzTE8z3sE1cNiKFmGmMremYjdqrg8+vicQ=;
        b=AXHffRSvDWyjlmShuicjZiUif9459H3iwmdKZiDPhFJtpxzSr/cadcpRJn6y0FfUod
         yb5Qw6nakLdJSiFEm9QTLnk7s46fUdQ2Ol9078GMm8S0DrEsvd5ccVR3FJOVBqVikLXV
         ObdMSSAViLyPhBKMqQutb7/ttxySEoSm59X0DYNLfAtL5drTReLcutRaKBLijZhxkkc+
         VyhSAHxdQAoxOnv7/5IGhB3cLdnfLvpbhR4d3l1kNSQh/jMXBbMVKUNFLXv1fptWa9H/
         4pCoaMZDMKwD4cRrKBAZqF4AWx4d6/HbSJWaxdOHzP1N76KsveuSKy0O0RnMZ6fXBhj+
         Q6wg==
X-Forwarded-Encrypted: i=1; AJvYcCVdAAAfjI4TT0apuHF57pj+uZmiPhjSoKYdjbV482qC9iexph9HjP2smAykmYhXmCRIrz8FeIDznMVd0A==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy+G7I/T3Bq3fZnkXt0NQJdvyzbmP7plegeBBcNYumvC3nBxatM
	Z/nfPgn5Slnd/ONSzP8zfoDAsrG/If95i78YiFo55Kk5NN8tNtTQy/hxrQKp5hE=
X-Gm-Gg: ASbGncuBnd4elSOQ25kch2HSbG1LcsyavycxKb0sOMwsh0TyhxJDZpKBGxWqcMG3KJ6
	mr2inh5vU1tyFt/yT23gAV/rnVbumoe9r0d6mhm0RFLVC4hzuWdPZqwx/Kv6GeVvWK+5yNJKLpD
	gG55doSkvujS2eOfLcF163zHCW112wuomY9T2FZVo67DX2odVWZjakoQ42xTU93jL00LCv/SXMR
	6KOQmarBnwzbR4WveQ9ypOWPwfY+6JONRos3JvSWYV1qv3VmagFVzXgHp4aCkDZo/CD5LwSk8KY
	9MmP6a/udHxRzlRrUdr5tqk8MpGZYe65
X-Google-Smtp-Source: AGHT+IHnPTYH1M0KygFma+wZwcgjOIPDIchY7x9E9r6aOBRHS7OOYUKAFanmi2DmZuTGwBHC8Eg84w==
X-Received: by 2002:a17:903:32ce:b0:215:b8c6:338a with SMTP id d9443c01a7336-21a83f338a5mr470115445ad.4.1736972006983;
        Wed, 15 Jan 2025 12:13:26 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f219f0dsm86031465ad.139.2025.01.15.12.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 12:13:26 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tY9lT-00000006JFt-3Jp5;
	Thu, 16 Jan 2025 07:13:23 +1100
Date: Thu, 16 Jan 2025 07:13:23 +1100
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/8] dcache: use lockref_init for d_lockref
Message-ID: <Z4gW4wFx__n6fu0e@dread.disaster.area>
References: <20250115094702.504610-1-hch@lst.de>
 <20250115094702.504610-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115094702.504610-7-hch@lst.de>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Dave Chinner via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Dave Chinner <david@fromorbit.com>
Cc: Christian Brauner <brauner@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, linux-kernel@vger.kernel.org, gfs2@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Jan 15, 2025 at 10:46:42AM +0100, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dcache.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index b4d5e9e1e43d..1a01d7a6a7a9 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1681,9 +1681,8 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
>  	/* Make sure we always see the terminating NUL character */
>  	smp_store_release(&dentry->d_name.name, dname); /* ^^^ */
>  
> -	dentry->d_lockref.count = 1;
>  	dentry->d_flags = 0;
> -	spin_lock_init(&dentry->d_lock);

Looks wrong -  dentry->d_lock is not part of dentry->d_lockref...

-Dave.

> +	lockref_init(&dentry->d_lockref, 1);
>  	seqcount_spinlock_init(&dentry->d_seq, &dentry->d_lock);
>  	dentry->d_inode = NULL;
>  	dentry->d_parent = dentry;
> -- 
> 2.45.2
> 
> 
> 

-- 
Dave Chinner
david@fromorbit.com
