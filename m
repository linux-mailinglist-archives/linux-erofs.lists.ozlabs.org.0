Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C916D79D5
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 12:37:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ps1KQ1hZjz3cKb
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 20:37:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i6AWuCju;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XEk2Z7ir;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=aalbersh@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i6AWuCju;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XEk2Z7ir;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ps1KD6SZcz3c6Y
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Apr 2023 20:37:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680691017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8hFqrvNZsn86teCYjqs2wVJUMFZmHeavzTexdU+dVHw=;
	b=i6AWuCjuba1cy6x2ZowUdnlU+ZxCpKJVi/LNaB/pJFQo2D/NxeJxGSZrDLtXfIIXoY4uTX
	Ct2WBcW8UeEfk4kDk/RuVrgHN8y5gx/Y/naQteIn/j/e2caQjcs2XJ+u3MK5iD48WH742U
	BuT4LBsqZ7Ur2LRBoDqpFbuLC0EBCig=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680691018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8hFqrvNZsn86teCYjqs2wVJUMFZmHeavzTexdU+dVHw=;
	b=XEk2Z7irBhNEy1mIxxm96EXc7rFvEkoUApCu4KCAIabmTGz5+nzXqYWhDcJvU84R1zazmJ
	u8Le2p2AsIPZxfyZ80okU3K/JH/qcJu6XzarlvuBSWeGfx+kQCNpW6oCzAtamuBZ7J+A6e
	+7UVbScJ4Wa1lSsfOotdSWmr8rvP+xY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-Mb75skuoORW6ktpX56Ny2w-1; Wed, 05 Apr 2023 06:36:48 -0400
X-MC-Unique: Mb75skuoORW6ktpX56Ny2w-1
Received: by mail-qk1-f199.google.com with SMTP id n129-20020a374087000000b0074a2ff16363so4776730qka.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 05 Apr 2023 03:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680691008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hFqrvNZsn86teCYjqs2wVJUMFZmHeavzTexdU+dVHw=;
        b=SHyPRq7U1ZsCQ76ITtgHKlmeUWxEubiKcBxScU7IcT8q06EvmJcPiZHDiPJJNynTMv
         yacUFFvrh10mO9+idRQlI8Wid2rn6QqqaBc1gBuMFKzuFDYFEx6lfRBJJtEMH1KPe91c
         9SXv3amYDFBMhd+x3wYCF+dZw47OQGpPtk4oTV1D0PIg0o6JYm3+aq/Ziy+n9/sSS6uR
         MtO72yVWqWXPIHg04IjQjVRfzWuRHiz7tF6P0GrvdJ7Brb/qiYwZhZaTNEpQpIGfD9zP
         bgEWxoGBYX+l5qeIo2WsE+9uOPOKdzpzK6qkvZIYLzbRVDX19Nl3mEoWArsaoYG0VKwm
         ktsw==
X-Gm-Message-State: AAQBX9edXTl3mtCI39KULQ7RpRFSOGcDf8gI7igDAq7pceBGdyOzM1Ic
	0IHN8i8fHxio3uRa8ndxR8/pHH2V2OApfyW0dIn6di5r99jhmFOaFmeZ/dI/6QuTM79I3YsNCkA
	LDfZqFa35uxLygWqTW/j+QXE=
X-Received: by 2002:a05:622a:181c:b0:3da:aa9b:105a with SMTP id t28-20020a05622a181c00b003daaa9b105amr4016633qtc.17.1680691008084;
        Wed, 05 Apr 2023 03:36:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yray4mqL/DA63FufP2W8G+Q2vCv/dEYqnAM/OkHjKwnv430c/AiUDk3FXiS3P6h8ilen17Eg==
X-Received: by 2002:a05:622a:181c:b0:3da:aa9b:105a with SMTP id t28-20020a05622a181c00b003daaa9b105amr4016592qtc.17.1680691007736;
        Wed, 05 Apr 2023 03:36:47 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id i2-20020ac84882000000b003d5aae2182dsm3911845qtq.29.2023.04.05.03.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 03:36:47 -0700 (PDT)
Date: Wed, 5 Apr 2023 12:36:42 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 05/23] fsverity: make fsverity_verify_folio() accept
 folio's offset and size
Message-ID: <20230405103642.ykmgjgb7yi7htphf@aalbersh.remote.csb>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-6-aalbersh@redhat.com>
 <ZCxCnC2lM9N9qtCc@infradead.org>
MIME-Version: 1.0
In-Reply-To: <ZCxCnC2lM9N9qtCc@infradead.org>
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, agruenba@redhat.com, djwong@kernel.org, damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christoph,

On Tue, Apr 04, 2023 at 08:30:36AM -0700, Christoph Hellwig wrote:
> On Tue, Apr 04, 2023 at 04:53:01PM +0200, Andrey Albershteyn wrote:
> > Not the whole folio always need to be verified by fs-verity (e.g.
> > with 1k blocks). Use passed folio's offset and size.
> 
> Why can't those callers just call fsverity_verify_blocks directly?
> 

They can. Calling _verify_folio with explicit offset; size appeared
more clear to me. But I'm ok with dropping this patch to have full
folio verify function.

-- 
- Andrey

