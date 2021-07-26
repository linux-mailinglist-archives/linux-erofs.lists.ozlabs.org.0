Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3733C3D536C
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Jul 2021 08:57:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GY9j31LJ7z2yyl
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Jul 2021 16:57:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SfUiMFNb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SfUiMFNb;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=agruenba@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=SfUiMFNb; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SfUiMFNb; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GY9hw13HLz2yLf
 for <linux-erofs@lists.ozlabs.org>; Mon, 26 Jul 2021 16:57:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627282633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hoM+40XrUs08/iafF0W5TlGWYGpGG8kF5CcKon7tTtw=;
 b=SfUiMFNbbUhTF/ECVTsz1dbYUlYG6jpX0pgPYkn2Gsn0bJUKNemSdOACttqEqYLwk3IElb
 FOBUrLspoqjF6tEzkg02fN0UFrbyIxqInbIBqIwKocNFj5trF9Ndd5KivZ7CmAun0W0LFp
 v7V8mZxL4yIffzLz0+Gg3/pIfRo+KrI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627282633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hoM+40XrUs08/iafF0W5TlGWYGpGG8kF5CcKon7tTtw=;
 b=SfUiMFNbbUhTF/ECVTsz1dbYUlYG6jpX0pgPYkn2Gsn0bJUKNemSdOACttqEqYLwk3IElb
 FOBUrLspoqjF6tEzkg02fN0UFrbyIxqInbIBqIwKocNFj5trF9Ndd5KivZ7CmAun0W0LFp
 v7V8mZxL4yIffzLz0+Gg3/pIfRo+KrI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-tjloAF1rNlmqJFpZqrzBYw-1; Mon, 26 Jul 2021 02:57:11 -0400
X-MC-Unique: tjloAF1rNlmqJFpZqrzBYw-1
Received: by mail-wr1-f69.google.com with SMTP id
 c5-20020adfed850000b02901537ecbecc6so1129713wro.19
 for <linux-erofs@lists.ozlabs.org>; Sun, 25 Jul 2021 23:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hoM+40XrUs08/iafF0W5TlGWYGpGG8kF5CcKon7tTtw=;
 b=YR6Hm5z2te84c2a2/7yltNfRQro0UIxCgmUnZe3dWkOozoL0hPv4N5Iztu4v1Y2X4/
 /prmk8abUuyb+iwCAAGQpmNMGDaClOLaeaVxQ++1EYh4gjwkfUObezsP65o99SHcqyxP
 U0zt1Z8HkkYtSfYtN+9cHJFQlQIuWKa7lvaetesyj35oZC01Z14LBxlUsoBeFNi69uKP
 YI2wFHmI6Kg3srarPM21dnOaTB7xoot0aD7sQiB3JVpguaGKQ2/NFmbY+MCJcjk/rlDR
 j3FudaR0SxSagrVkUdaU5nqihqxn8QYcq8rOwjUU329sGbU+l6p8CANRZDFabrXeH/qK
 rTmA==
X-Gm-Message-State: AOAM530IQ7DhCJE2igOC+i7y76xQ26px4j3/DKzxyyQ65hpKKv/iFk4k
 d/sqIkiI/79TPvea6I/F6uPPxT1dc1/lZkXHj41FbWmMdGFtlyD2FimsxN/gnY/gSRdys8/PWIJ
 Hy5mr/uiISXX4RlplWuHjQwuw0SdB3NHDnUaI1ZNl
X-Received: by 2002:a05:600c:2319:: with SMTP id
 25mr9998438wmo.27.1627282629855; 
 Sun, 25 Jul 2021 23:57:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1d7vnal7HJ1PcZ4njvl3+oYt3GMB7C300ETtzmpr8AsBsi2dyhup0b5RU8e3Tw7o3XKPki+Q+cwnpDOXFJvY=
X-Received: by 2002:a05:600c:2319:: with SMTP id
 25mr9998417wmo.27.1627282629625; 
 Sun, 25 Jul 2021 23:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
 <20210725221639.426565-1-agruenba@redhat.com>
 <YP4mzBixPoBgGCCR@casper.infradead.org>
In-Reply-To: <YP4mzBixPoBgGCCR@casper.infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 26 Jul 2021 08:56:58 +0200
Message-ID: <CAHc6FU6C44b=u3YJmL9VSZGwLK3wAVxgnNdxx87RmEwVbRUB=w@mail.gmail.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
To: Matthew Wilcox <willy@infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=agruenba@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Darrick J . Wong" <djwong@kernel.org>,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 26, 2021 at 5:07 AM Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, Jul 26, 2021 at 12:16:39AM +0200, Andreas Gruenbacher wrote:
> > @@ -247,7 +251,6 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> >       sector_t sector;
> >
> >       if (iomap->type == IOMAP_INLINE) {
> > -             WARN_ON_ONCE(pos);
> >               iomap_read_inline_data(inode, page, iomap);
> >               return PAGE_SIZE;
>
> This surely needs to return -EIO if there was an error.

Hmm, right.

Thanks,
Andreas

