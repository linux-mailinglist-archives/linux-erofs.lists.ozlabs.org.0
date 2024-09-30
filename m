Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B2198AC70
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Sep 2024 21:00:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XHVky4nWvz304l
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Oct 2024 05:00:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727722823;
	cv=none; b=WaK8NLFt5G9ldhxtchxMBnjuVWXyzZM0+XBW+806xgnx+CAxIJarvDTZ+OKuFeI+Iv3oR7Jg1lU3TQjPObfguXv0g72Y9VtweUQbjmu6McLhI/+fkAeL6HQQGOJl3Rj96ImVrSC/XhIKfNid5n1ztU6Vue/fj60gHOt48AjzENsZu+0kGaQ2Pv/D0U95zkM8FGKzUmobPERDBsc0aItPGYGKEeO/0UR3Vdiab8SDJleaxoQS8HDL313o8vCr2ApIcvAkSpWLkHHstFlma+54cmbcoCSlWlyvDUw8dIBvVAA7bKACYZJt13JmGsN2cbXD34L2qA51uQ3lRb8Wt91nQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727722823; c=relaxed/relaxed;
	bh=tK4zHMv9BgdsXfJFkQFkyqT5Q9MVxMalN7pOJK+VYMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSClPeA5Lll07NzGSJaSFK3kR45KarVSXNdxOUIusCtV7nYm0uqdDiUe3lOTq/olj+83OOY1QunnTD8P99fCvDm+nIbKgIovmlVav6HxPKPz2DMnlShOJX++AjOKMTtNUDmMM0sAqVtDMbulyJtLgbziiKDuSEEK7SePaGgeGaeJbefTxHxJjPiZhcmgLE2igb0QEt322sBU9LcvqZk2bqTzq+AJWDZJHcckceKX0uj894qQHircSldWzj1Gva+X+eU8Yj7Rqu6pSe58TXxl6l5FdJ5ENRSbCPI06T540n7ADjB9Alr6fkDORrxQkqq4Fpkrt8ObDlDQtfsdxb+Gkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=osandov.com; dkim=pass (2048-bit key; unprotected) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=IpFSOa4i; dkim-atps=neutral; spf=none (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=osandov@osandov.com; receiver=lists.ozlabs.org) smtp.mailfrom=osandov.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=IpFSOa4i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=osandov.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=osandov@osandov.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XHVkt4bxhz2y92
	for <linux-erofs@lists.ozlabs.org>; Tue,  1 Oct 2024 05:00:22 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-717839f9eb6so567064b3a.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 30 Sep 2024 12:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1727722818; x=1728327618; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tK4zHMv9BgdsXfJFkQFkyqT5Q9MVxMalN7pOJK+VYMc=;
        b=IpFSOa4inRciG+bysiDMZ5jc5Z1oBHbww3KdCQT8ZftEswJfeE202LJ7HAjHFGGM+d
         ZhlZgMQ4FH/+yeAwOMWqgm6bVJDNgikiXPoReNcawBzMbniksw4YTJ8E4/voUd0N0pnQ
         LhFNr3YsBVUBO3SDPCSB6ICn9OOZAOByXFc56hjU34aLydZC8ZsyhrdbL7keuiCr66+t
         BaYkDaQY9xTO844+m4Ij0QreuLHddZt1McgH+seCVNnrwWPiGgOHX1JWVWkI+VjLTEY1
         yP4wEWYqqi1sP1FwcL3pE4CF/MX3rLIZMDim/fekSpRrBmaAt+U2RWHtrRtFjiUSoGaP
         36Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727722818; x=1728327618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tK4zHMv9BgdsXfJFkQFkyqT5Q9MVxMalN7pOJK+VYMc=;
        b=BBaewwEgoT6iYnmvGcayWD37u9RCBR5NMTceWujEbxseF4XIGG/0edd+q4X2x2z0OT
         GqkSZRO3bYzhLxSNlIExT5tK7U3Zoe2kCrpkBCkcUgNAqOtTssAz2ehiTojHmk4DosVK
         nCBj26YPjR3MwB+E6NRvMbukK+Un7h6o9FnPrvak/SAM3hFONUKtfe6iZmE6CbTv299n
         bc1dBPUcG/DMTpBB7UYOtgB0CdQd/1vbStwoFd+8YxRJyRnP+Rc3pDJzlmkT2J1ueHD1
         EpiXi+J9ktZ9f5+oSD/yACyyoHMEruKy5oHlBHLzgecb0Y1b+P+6V3P/U+Iec70f5ex7
         ggng==
X-Forwarded-Encrypted: i=1; AJvYcCVi4npQwHRJsI7idGQkn6/6bvAnnSPUVDRflipoTelAagjdlNkFPj9h0pInxZcbG4cjEkAH+xEcc00GJg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz1MckqY32DczDaNoerCuJAwOzvXBu0LrNHZRsNKqby0pIQBELP
	acZv5dh9Kdq9/zbo7d2cg1z5CnX3DlLv7aDfmU0SUvkkC6OFLEQNdPehLHm/36k=
X-Google-Smtp-Source: AGHT+IHr3t4octArrJkwK4KlggdiRYNEixY4E7CvOHzMJxxuBtEfGjyLTrjjT9DROP00qxEU234jog==
X-Received: by 2002:a05:6a00:2392:b0:718:e49f:246e with SMTP id d2e1a72fcca58-71b260a8a3fmr8397735b3a.6.1727722818090;
        Mon, 30 Sep 2024 12:00:18 -0700 (PDT)
Received: from telecaster.dhcp.thefacebook.com ([2620:10d:c090:500::6:e49b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2652a622sm6544654b3a.164.2024.09.30.12.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 12:00:17 -0700 (PDT)
Date: Mon, 30 Sep 2024 12:00:13 -0700
From: Omar Sandoval <osandov@osandov.com>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
Message-ID: <Zvr1PVRpC33aaUdt@telecaster.dhcp.thefacebook.com>
References: <423fbd9101dab18ba772f24db4ab2fecf5de2261.camel@gmail.com>
 <2968940.1727700270@warthog.procyon.org.uk>
 <20240925103118.GE967758@unreal>
 <20240923183432.1876750-1-chantr4@gmail.com>
 <20240814203850.2240469-20-dhowells@redhat.com>
 <1279816.1727220013@warthog.procyon.org.uk>
 <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com>
 <2969660.1727700717@warthog.procyon.org.uk>
 <3007428.1727721302@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3007428.1727721302@warthog.procyon.org.uk>
X-Spam-Status: No, score=0.0 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,SPF_HELO_NONE,SPF_NONE autolearn=disabled
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
Cc: asmadeus@codewreck.org, linux-mm@kvack.org, marc.dionne@auristor.com, linux-afs@lists.infradead.org, pc@manguebit.com, linux-cifs@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Manu Bretelle <chantr4@gmail.com>, willy@infradead.org, smfrench@gmail.com, hsiangkao@linux.alibaba.com, idryomov@gmail.com, sprasad@microsoft.com, linux-nfs@vger.kernel.org, tom@talpey.com, ceph-devel@vger.kernel.org, ericvh@kernel.org, christian@brauner.io, Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org, v9fs@lists.linux.dev, jlayton@kernel.org, linux-kernel@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Sep 30, 2024 at 07:35:02PM +0100, David Howells wrote:
> Eduard Zingerman <eddyz87@gmail.com> wrote:
> 
> > Are there any hacks possible to printout tracelog before complete boot
> > somehow?
> 
> You could try setting CONFIG_NETFS_DEBUG=y.  That'll print some stuff to
> dmesg.
> 
> David

I hit this in drgn's VM test setup, too, and just sent a patch that
fixed it for me and Manu:
https://lore.kernel.org/linux-fsdevel/cbaf141ba6c0e2e209717d02746584072844841a.1727722269.git.osandov@fb.com/

Thanks,
Omar
