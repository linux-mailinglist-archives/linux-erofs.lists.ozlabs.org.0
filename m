Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 9072F2A0584
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Oct 2020 13:34:43 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CN1wK0lpBzDqkP
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Oct 2020 23:34:41 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=Bhrq+dOg; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BgZff4qm; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CN1wC75cwzDqdP
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Oct 2020 23:34:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604061272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XAmzxJQllJxgJKv1AtyeQXuYcVwa9Qk2yemCyLRyAiY=;
 b=Bhrq+dOgvATRr0zrN7CDnh0qEQ1e2AUiAQc2Knd048OiB8V47JYoBeSGvCKkWVnQ6kicmb
 MelQzxfuN4BeczxkJmJhx/QXv01PZh1OB4MtGtSyaNMAsuZFLj3fX8WEDzDb8HEtw3nK3C
 Ki+C34ZmdRNMUgfqL7B/b6shfB0bNwU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604061273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XAmzxJQllJxgJKv1AtyeQXuYcVwa9Qk2yemCyLRyAiY=;
 b=BgZff4qmh5n7hCsAdgaYkzPUG/r3ShW8Kc2i0QwZ39ceNCLgYoCWJwYPC2UXw+UKgvpxjx
 GU7A2N3WV6w4qdK7bTI6Utdt5nGkOLa0/GA9qRG3LWEfg0i0+Txmh7Jcyb1j1vnFWRoMdf
 TU7UsF7sHAktONv9fkZC2wc102Nj4Bg=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-PtSEVPvZOGyREeDRWPqbSg-1; Fri, 30 Oct 2020 08:34:31 -0400
X-MC-Unique: PtSEVPvZOGyREeDRWPqbSg-1
Received: by mail-pf1-f198.google.com with SMTP id s12so4739133pfu.11
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Oct 2020 05:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XAmzxJQllJxgJKv1AtyeQXuYcVwa9Qk2yemCyLRyAiY=;
 b=hQUifvHLgtGX/Jqsip44+PCVEVm+s8dt6Q4SGvKhNr158j1bIM4Ty11CcG1RkG0Iq5
 XguN3voQp5UpbIZOtDpvbjHBzRoH4PGd1uLVuq7DJ8/Tf1kmbnu9nhh9UorYn0nWKGtR
 9fyX5Z1qjKznflhprgDgW4uZa0gcPYTlK8dXq/smDYtx2HhuTAyoDwRdu/gAnHsQDe9W
 47zvEw8wRVB5cvmhfOGvVv9I948uN+LyegX9vTLidIXrprY6L1EHHV0qd6LIhZCbmLuV
 A942Rubj4wDXhc0zTL+5Bt3rcM8pbUBqktK7Qd4KeRoyXA9YH+Uj4i/PxQXHwIm0yAHO
 ceQg==
X-Gm-Message-State: AOAM5329eO9RzOCibSQ7lyejawjUqF70ml/IabL6eDOpIaOcePjJ8GXA
 WQ3ABPBLm8ZglswJlcq6IiscHA5uCuBPhd41k+a7jyep2dxRv95jcOob++0wECJbiK5Yu+XLbWw
 MrM1jqJ/I1MYTv2v1PnYPM7m1
X-Received: by 2002:a17:90b:3587:: with SMTP id
 mm7mr2806932pjb.234.1604061270051; 
 Fri, 30 Oct 2020 05:34:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxGfhu1ixzQl8L3gVldvcEGQyW1KMLuNZzEaD+gErasEeEcIsym8gjNEOXQp67FCmvq2rrYA==
X-Received: by 2002:a17:90b:3587:: with SMTP id
 mm7mr2806914pjb.234.1604061269892; 
 Fri, 30 Oct 2020 05:34:29 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id v3sm3522986pjk.23.2020.10.30.05.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 05:34:29 -0700 (PDT)
Date: Fri, 30 Oct 2020 20:34:19 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Vladimir Zapolskiy <vladimir@tuxera.com>
Subject: Re: [PATCH] erofs: remove a void EROFS_VERSION macro set in Makefile
Message-ID: <20201030123419.GA133455@xiangao.remote.csb>
References: <20201030122839.25431-1-vladimir@tuxera.com>
MIME-Version: 1.0
In-Reply-To: <20201030122839.25431-1-vladimir@tuxera.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
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
Cc: Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Oct 30, 2020 at 02:28:39PM +0200, Vladimir Zapolskiy wrote:
> Since commit 4f761fa253b4 ("erofs: rename errln/infoln/debugln to
> erofs_{err, info, dbg}") the defined macro EROFS_VERSION has no affect,
> therefore removing it from the Makefile is a non-functional change.
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>
> ---

Yeah, since we have feature bits now, and fs runtime version
isn't very important... Thanks for doing this!

Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

Thanks,
Gao Xiang

