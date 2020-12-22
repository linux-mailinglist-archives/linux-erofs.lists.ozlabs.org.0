Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 882F42E08EC
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 11:47:22 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D0Y200TWhzDqQS
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 21:47:20 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=ZADjlwlu; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZADjlwlu; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D0Y1x4YPpzDqPl
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 21:47:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608634033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kjZKEN03koMQjNcxahXqn9LF8k/WU77SOTtraX1fftM=;
 b=ZADjlwlurOt/dTmitzgPRmHaqKm7e32pcZRWlX/7hRgi58u4E51zELWTJlvsAxz+oeqSn4
 tDDwr283laKDG9lgd8pEOqfExufavsy9Jctc+oOJzFHQfSZAR7PJFXV4ZU0uMTA37sX7cz
 Zd1ODOKZ5/sVcTYNCzvhedGVSdq4EiI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608634033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kjZKEN03koMQjNcxahXqn9LF8k/WU77SOTtraX1fftM=;
 b=ZADjlwlurOt/dTmitzgPRmHaqKm7e32pcZRWlX/7hRgi58u4E51zELWTJlvsAxz+oeqSn4
 tDDwr283laKDG9lgd8pEOqfExufavsy9Jctc+oOJzFHQfSZAR7PJFXV4ZU0uMTA37sX7cz
 Zd1ODOKZ5/sVcTYNCzvhedGVSdq4EiI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-PipAqaKSPKeJnaLFNJz4Yw-1; Tue, 22 Dec 2020 05:47:12 -0500
X-MC-Unique: PipAqaKSPKeJnaLFNJz4Yw-1
Received: by mail-pj1-f70.google.com with SMTP id 25so1066439pjb.5
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 02:47:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=kjZKEN03koMQjNcxahXqn9LF8k/WU77SOTtraX1fftM=;
 b=INqtEordXy2S8TBzF66fIyuaft42CLOwqqce1Ygqt5MzW7GVvXzXzicf4NAiqxsVja
 hpwiEuI4rSDrW1vwSHoZZqB78YDaNi1A0pQ4YYYwdKckidMJhcy559y4owjpzkcL9/xA
 QOUGFbdQa8ZmFJpNSIvztxSqpjtijOzuKGyWGKa3gV2eTQV2uwZeRskmLCjlo/brr5fd
 vEQr+QqbZVr1IFWqGXePSSVqD8hUQkqWHT09ncHKPTx1bM5BtaNk2hdF1ehBMJtxqBuX
 DLGUxvDOJHaISP18gPvmNHYDU+Tw3bxqSVIGVm7j7seXkjekJNXwqPmxmakL9N9Cp21f
 ECrw==
X-Gm-Message-State: AOAM530HoB18UURjTzS2w4QE6LmrS63yDfwhBbGlub2Xc+uKMuEbdwLj
 bkN4AleZQ14Alg4VCrfHt8BLzJzJqm1RvrS1E+BqJwXHBZiYR3sTK/8d+lfsZaZaiH7J2plZq2/
 /d3SUsMZa124IHj3LsY9eXpt6
X-Received: by 2002:a17:90b:8d5:: with SMTP id
 ds21mr21019891pjb.5.1608634031045; 
 Tue, 22 Dec 2020 02:47:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwi+UK0NFZ/FxZgjglP8mkfy1kj8MpOswPFsLDpft0aoQtUa3HgtoPgPFJ9RltHhPfsZ8jH2Q==
X-Received: by 2002:a17:90b:8d5:: with SMTP id
 ds21mr21019874pjb.5.1608634030831; 
 Tue, 22 Dec 2020 02:47:10 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id s7sm19620311pfh.207.2020.12.22.02.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Dec 2020 02:47:10 -0800 (PST)
Date: Tue, 22 Dec 2020 18:47:00 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] AOSP: erofs-utils: fix sub directory prefix path in
 canned fs_config
Message-ID: <20201222104700.GB1831635@xiangao.remote.csb>
References: <20201222020430.12512-1-zbestahu@gmail.com>
 <20201222034455.GA1775594@xiangao.remote.csb>
 <20201222124733.000000fe.zbestahu@gmail.com>
 <20201222063112.GB1775594@xiangao.remote.csb>
 <20201222070458.GA1803221@xiangao.remote.csb>
 <20201222160935.000061c3.zbestahu@gmail.com>
 <20201222091340.GA1819755@xiangao.remote.csb>
 <20201222173014.000055d3.zbestahu@gmail.com>
 <20201222093952.GC1819755@xiangao.remote.csb>
 <20201222183411.00004854.zbestahu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201222183411.00004854.zbestahu@gmail.com>
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
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org, huyue2@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Dec 22, 2020 at 06:34:11PM +0800, Yue Hu wrote:

...

> > 
> > Hmmm... such design is quite strange for me....
> > Could you try the following diff?
> > 
> > diff --git a/lib/inode.c b/lib/inode.c
> > index 9469074..9af6179 100644
> > --- a/lib/inode.c
> > +++ b/lib/inode.c
> > @@ -698,11 +698,14 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
> >  	/* filesystem_config does not preserve file type bits */
> >  	mode_t stat_file_type_mask = st->st_mode & S_IFMT;
> >  	unsigned int uid = 0, gid = 0, mode = 0;
> > +	bool alloced;
> >  	char *fspath;
> >  
> >  	inode->capabilities = 0;
> > -	if (!cfg.mount_point)
> > -		fspath = erofs_fspath(path);
> > +
> > +	alloced = (cfg.mount_point && erofs_fspath(path)[0] != '\0');
> > +	if (!alloced)
> > +		fspath = (char *)erofs_fspath(path);
> >  	else if (asprintf(&fspath, "%s/%s", cfg.mount_point,
> >  			  erofs_fspath(path)) <= 0)
> >  		return -ENOMEM;
> > @@ -718,7 +721,7 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
> >  			  cfg.target_out_path,
> >  			  &uid, &gid, &mode, &inode->capabilities);
> >  
> > -	if (cfg.mount_point)
> > +	if (alloced)
> >  		free(fspath);
> >  	st->st_uid = uid;
> >  	st->st_gid = gid;
> > 
> > if it works, will redo a formal patch then....
> 
> Works for me for canned fs_config.

Ok, if it also works fine for non-canned fs_config on your side,
I will redo a formal patch later... sigh :(

Thanks,
Gao Xiang

> 
> Thx.

