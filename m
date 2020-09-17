Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B9726D10F
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Sep 2020 04:21:45 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BsLLt49SSzDqQN
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Sep 2020 12:21:42 +1000 (AEST)
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
 header.s=mimecast20190719 header.b=ibVGEe9X; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ibVGEe9X; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BsLLh6y0nzDqGN
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Sep 2020 12:21:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600309286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N4dsBjdtcU4ASBhl61wjASbXtJpfQbVEgyM+D/rYJHU=;
 b=ibVGEe9XPpT25cy0iAo07NdxnCbS6CtG+Sl6Dovr4qrbDCuKa6HpJFwkkhh8DO1Tlh9GX5
 2XGl/HVz4/dGF7tPVum4FD2r7QXo07QQ1KxBxf3PtMCGJFon6Eho+q3TiJ9wwnJhjZcDLU
 bcQajraSQfnLElXy0xqFsCC57MCh3/w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600309286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N4dsBjdtcU4ASBhl61wjASbXtJpfQbVEgyM+D/rYJHU=;
 b=ibVGEe9XPpT25cy0iAo07NdxnCbS6CtG+Sl6Dovr4qrbDCuKa6HpJFwkkhh8DO1Tlh9GX5
 2XGl/HVz4/dGF7tPVum4FD2r7QXo07QQ1KxBxf3PtMCGJFon6Eho+q3TiJ9wwnJhjZcDLU
 bcQajraSQfnLElXy0xqFsCC57MCh3/w=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-EPdrZzreNUqwmHGS-q-bWQ-1; Wed, 16 Sep 2020 22:21:22 -0400
X-MC-Unique: EPdrZzreNUqwmHGS-q-bWQ-1
Received: by mail-pg1-f199.google.com with SMTP id a184so490483pgc.16
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Sep 2020 19:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=N4dsBjdtcU4ASBhl61wjASbXtJpfQbVEgyM+D/rYJHU=;
 b=q65jkYV5v4z86CLbSPOZ2AIzLlxOJ0+LNupcYI8d+jzdMyCa67s6zzgyStykFFWeou
 qY+QN53D6gU4XPIOLIPTeXVYl/f2D9/yAXl4NcuYmI+ImqUi4ZCev4E81BUtXFUU52qT
 9A7BCkEpSyezmDzOjqhtehqiBGQ8Gi66F6UF9lDS92X11EpRoYpMZO6tNZIS5QamEjb8
 WfkBhe2qagGYPk4YbLVmRipuZCLzCMajr52s1HxS0SmYCfOU6Wuis+oLBb0nF8S9Vj37
 fsa1TFF++u6LNaV4rDdGK/HWwy7fO51dbCjShuewuntZ6lCADfVBxl4OIOxnBefc3Div
 b/Fw==
X-Gm-Message-State: AOAM530u8BM6BOx2rPYo83DwcTt1YIgsSZuCm6+wXDSkUV8lAgaPm3lL
 Zg/tZw7CDYN2M3fktiVQg/av9gLOkpguG6g0J/LzCbpgGDqBvq8fVEuSWRhLMDKSoJU9qRw175w
 uTU4GUAIqJrCSC13dbhl60tHq
X-Received: by 2002:aa7:9a90:0:b029:142:2501:39e7 with SMTP id
 w16-20020aa79a900000b0290142250139e7mr9108785pfi.54.1600309281153; 
 Wed, 16 Sep 2020 19:21:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeaJVz11MtazIIwXq4sTHziPNu0GZHEoeqcQaC+iA9ZRm+rBmogCojJtJL/NsMAtaxH6rGbA==
X-Received: by 2002:aa7:9a90:0:b029:142:2501:39e7 with SMTP id
 w16-20020aa79a900000b0290142250139e7mr9108776pfi.54.1600309280942; 
 Wed, 16 Sep 2020 19:21:20 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id i17sm18191887pfa.2.2020.09.16.19.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 19:21:20 -0700 (PDT)
Date: Thu, 17 Sep 2020 10:21:10 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] erofs: remove unneeded parameter
Message-ID: <20200917022110.GA18734@xiangao.remote.csb>
References: <20200917011821.22767-1-yuchao0@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200917011821.22767-1-yuchao0@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Sep 17, 2020 at 09:18:21AM +0800, Chao Yu wrote:
> After commit 0615090c5044 ("erofs: convert compressed files from
> readpages to readahead"), add_to_page_cache_lru() was moved to mm
> code, so that in below call path, no page will be cached into
> @pagepool list or grabbed from @pagepool list:
> - z_erofs_readpage
>  - z_erofs_do_read_page
>   - preload_compressed_pages
>   - erofs_allocpage
> 
> Let's get rid of this unneeded @pagepool parameter.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

Will apply it later :)

Thanks,
Gao Xiang

