Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7D76D82DC
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 18:04:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ps8b13nyjz3cjJ
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 02:04:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WZQDHh+o;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WZQDHh+o;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=aalbersh@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WZQDHh+o;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WZQDHh+o;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ps8Zw1G4Yz3cKb
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Apr 2023 02:04:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680710661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ezrY1MpbuGn54W85nscQkQabj0tChDh4QyAKrhiN160=;
	b=WZQDHh+of/UYNZ2stDGY9PzROsTjfchHFxGKS5F1+FlDvGBU9IXS5pBpRk9ozdWxSlwwmX
	TteqVqcNE+f5rCMnquCTtvjXuolTGWtyMInBbiCBByk28kx9bAYWk9WMffQrfKlrz5FJyn
	RKiBK6G2l+U0Sen6jfOFJRi15JdcUs8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680710661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ezrY1MpbuGn54W85nscQkQabj0tChDh4QyAKrhiN160=;
	b=WZQDHh+of/UYNZ2stDGY9PzROsTjfchHFxGKS5F1+FlDvGBU9IXS5pBpRk9ozdWxSlwwmX
	TteqVqcNE+f5rCMnquCTtvjXuolTGWtyMInBbiCBByk28kx9bAYWk9WMffQrfKlrz5FJyn
	RKiBK6G2l+U0Sen6jfOFJRi15JdcUs8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-F6VVFSarOMS09xCo96ldqw-1; Wed, 05 Apr 2023 12:04:20 -0400
X-MC-Unique: F6VVFSarOMS09xCo96ldqw-1
Received: by mail-qv1-f71.google.com with SMTP id l18-20020ad44bd2000000b005a9cf5f609eso16452587qvw.15
        for <linux-erofs@lists.ozlabs.org>; Wed, 05 Apr 2023 09:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680710659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezrY1MpbuGn54W85nscQkQabj0tChDh4QyAKrhiN160=;
        b=peUgihQoEmhjFOKK2UWrzDHtnAxQbd62EFvjPwsXPNp8CEgJpHe+SWWjWVMZnuehtE
         1qCdO8/yUNowkiTJFINbLdzBOsrPewu9OAgPMc0qhpz9EKPGBw3woWGV7BwF6v1p53/L
         ZIVjwJDgT2qywaPhWb8KSUpXWaONZRVk9g7OCv00cKjV3NvKTbq12pVEUFAYQ6uWFzpX
         bPjqsPLGWAkDnYgNCDRmiJxAqpemlNNKVaGipE+/wfDLl2kLqyV5FfLcgHYOqvWDrBXC
         1+mw987mZGFyjT6V0Zmerb17oebR1sOGUQ8fDX5adWDLNvL2mu7FnMcLTS5ZfEsy6cKY
         B1hQ==
X-Gm-Message-State: AAQBX9dvWuFO14/CcRDkx6ySyzN2X8gQk1G786SEhk6AHeUqs/NNd+LL
	1+1vUbkx38nm1O97a2bYNykEAnk+O65r7pnGYmGzxFORJJg3gvJdlH++hnxI718s2lxZhWZQ+Ct
	b7hTJJgQMcoxgO7vWjs4mav0=
X-Received: by 2002:a05:622a:4b:b0:3d8:8d4b:c7cc with SMTP id y11-20020a05622a004b00b003d88d4bc7ccmr7038034qtw.46.1680710659548;
        Wed, 05 Apr 2023 09:04:19 -0700 (PDT)
X-Google-Smtp-Source: AKy350a5lKksulKGDz1s6x8IlpR6R6JUlCw8aCDbcTRwKrjAxeI/G0vqKKfr43MPgy1YnBz9zPAfFA==
X-Received: by 2002:a05:622a:4b:b0:3d8:8d4b:c7cc with SMTP id y11-20020a05622a004b00b003d88d4bc7ccmr7037982qtw.46.1680710659193;
        Wed, 05 Apr 2023 09:04:19 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id b9-20020ac84f09000000b003e398d00fabsm4083588qte.85.2023.04.05.09.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 09:04:18 -0700 (PDT)
Date: Wed, 5 Apr 2023 18:04:13 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2 00/23] fs-verity support for XFS
Message-ID: <20230405160413.7o7tljszm56e73a6@aalbersh.remote.csb>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404233713.GF1893@sol.localdomain>
MIME-Version: 1.0
In-Reply-To: <20230404233713.GF1893@sol.localdomain>
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, agruenba@redhat.com, djwong@kernel.org, damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net, hch@infradead.org, cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Apr 04, 2023 at 04:37:13PM -0700, Eric Biggers wrote:
> On Tue, Apr 04, 2023 at 04:52:56PM +0200, Andrey Albershteyn wrote:
> > The patchset is tested with xfstests -g auto on xfs_1k, xfs_4k,
> > xfs_1k_quota, and xfs_4k_quota. Haven't found any major failures.
> 
> Just to double check, did you verify that the tests in the "verity" group are
> running, and were not skipped?

Yes, the linked xfstests in cover-letter has patch enabling xfs
(xfsprogs also needed).
> 
> - Eric
> 

-- 
- Andrey

