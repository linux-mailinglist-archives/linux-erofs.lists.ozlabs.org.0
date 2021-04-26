Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A0236AFE3
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Apr 2021 10:43:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FTJMM3Cn9z2yxx
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Apr 2021 18:43:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DsFFuYmK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DsFFuYmK;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=DsFFuYmK; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DsFFuYmK; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FTJMK4cwRz2xg4
 for <linux-erofs@lists.ozlabs.org>; Mon, 26 Apr 2021 18:43:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619426602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wz6WYdlaJ9ziC7ExdEujknNmn1q4Z9TPX1vLmCnL7NU=;
 b=DsFFuYmKWV+FXszMoJ7SfbTEf8HnBRvw/srkhoua3FOtP5zpeDLyBHYxjlLTVXiPr9DUMw
 qWFn0FeTHjcdMpZDQ00DSI90Q5kkuIhH+hzOZN9UTimx0CFR98S5Ej1jfc8SrNzpSGwopX
 VshmllmFFwmdPPAk/y7kE9Hz/lkrwIU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619426602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wz6WYdlaJ9ziC7ExdEujknNmn1q4Z9TPX1vLmCnL7NU=;
 b=DsFFuYmKWV+FXszMoJ7SfbTEf8HnBRvw/srkhoua3FOtP5zpeDLyBHYxjlLTVXiPr9DUMw
 qWFn0FeTHjcdMpZDQ00DSI90Q5kkuIhH+hzOZN9UTimx0CFR98S5Ej1jfc8SrNzpSGwopX
 VshmllmFFwmdPPAk/y7kE9Hz/lkrwIU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-20tTK8fRMNC3IRwou1m5vg-1; Mon, 26 Apr 2021 04:43:20 -0400
X-MC-Unique: 20tTK8fRMNC3IRwou1m5vg-1
Received: by mail-pj1-f70.google.com with SMTP id
 f8-20020a17090a9b08b0290153366612f7so7645448pjp.1
 for <linux-erofs@lists.ozlabs.org>; Mon, 26 Apr 2021 01:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Wz6WYdlaJ9ziC7ExdEujknNmn1q4Z9TPX1vLmCnL7NU=;
 b=FH8wqlYTCIevYXZ7QJnynudLmeG29F82YUAPlQ6micL75ehVsFUcN4xqoCxnCOSqDZ
 jDRZB6s0AG+N7PqxVG7VaFKhbtFqurb5i9pC7iIB8hhwlxTRvTGKZjS0TYzZsZkCSZOT
 iyMEnCbtKnAvVWKrtNPvYM8CEtlLSBMRxQh7Fo3jhLxsLP4+a1IUq1ifRTx2Fy7LlqVN
 X2YCS1Qdz0MQk/m0hHisnA5KscZW/9xNnaHLepwNF730PH5ZvgpB08s4bGdltoRe/w2Z
 ZB0bLpOt9NXaFWh6m8u703v5pUE3tbKS4F21VFp+ArKoMYeTbwCFlg67i/eQc+hpo3SV
 8Utw==
X-Gm-Message-State: AOAM530SP14/RIEB8f6GpHbeFz6panJpnwk/utkK73woLXRRs648UJh1
 2yupxUTPkDxiCL6mx7YIgnAwOoDnmFujJEF+VLPiH8wHH+XJdx3LwBDxaLABxzQVp+RwD0aLR18
 7YNj+hnAzler3oEO6WUNQODCX
X-Received: by 2002:a17:90a:a505:: with SMTP id
 a5mr19853533pjq.58.1619426599217; 
 Mon, 26 Apr 2021 01:43:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzondjCaj9YscCnoJ2g1s783lMBccvbn3/Gfn0Oft7LAapuFL8XWpxpeIQsHhkVOLee47FisQ==
X-Received: by 2002:a17:90a:a505:: with SMTP id
 a5mr19853514pjq.58.1619426599015; 
 Mon, 26 Apr 2021 01:43:19 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id m5sm5165251pjc.10.2021.04.26.01.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Apr 2021 01:43:18 -0700 (PDT)
Date: Mon, 26 Apr 2021 16:43:07 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH for-4.19] erofs: fix extended inode could cross boundary
Message-ID: <20210426084307.GA4042836@xiangao.remote.csb>
References: <20210426082933.4040996-1-hsiangkao@redhat.com>
 <YIZ8UOo0c2CLt8pl@kroah.com>
MIME-Version: 1.0
In-Reply-To: <YIZ8UOo0c2CLt8pl@kroah.com>
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
Cc: linux-erofs@lists.ozlabs.org, stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Apr 26, 2021 at 10:39:44AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 26, 2021 at 04:29:33PM +0800, Gao Xiang wrote:
> > commit 0dcd3c94e02438f4a571690e26f4ee997524102a upstream.
> > 
> > Each ondisk inode should be aligned with inode slot boundary
> > (32-byte alignment) because of nid calculation formula, so all
> > compact inodes (32 byte) cannot across page boundary. However,
> > extended inode is now 64-byte form, which can across page boundary
> > in principle if the location is specified on purpose, although
> > it's hard to be generated by mkfs due to the allocation policy
> > and rarely used by Android use case now mainly for > 4GiB files.
> > 
> > For now, only two fields `i_ctime_nsec` and `i_nlink' couldn't
> > be read from disk properly and cause out-of-bound memory read
> > with random value.
> > 
> > Let's fix now.
> > 
> > Fixes: 431339ba9042 ("staging: erofs: add inode operations")
> > Cc: <stable@vger.kernel.org> # 4.19+
> > Link: https://lore.kernel.org/r/20200729175801.GA23973@xiangao.remote.csb
> > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> > [ Gao Xiang: resolve non-trivial conflicts for latest 4.19.y. ]
> > Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> > ---
> >  drivers/staging/erofs/inode.c | 135 ++++++++++++++++++++++------------
> >  1 file changed, 90 insertions(+), 45 deletions(-)
> 
> Thanks for the backport, I'll queue it up after this latest round of
> stable kernels is released later this week.

Thanks Greg, sorry about the delay.
Sounds good to me.

Thanks,
Gao Xiang

> 
> greg k-h
> 

