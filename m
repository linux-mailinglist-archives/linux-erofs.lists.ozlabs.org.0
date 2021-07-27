Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FB33D799D
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jul 2021 17:23:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GZ0tw2x06z307t
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jul 2021 01:23:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=k1rZzZE6;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::12d;
 helo=mail-lf1-x12d.google.com; envelope-from=andreas.gruenbacher@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=k1rZzZE6; dkim-atps=neutral
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GZ0tp2Xksz3022
 for <linux-erofs@lists.ozlabs.org>; Wed, 28 Jul 2021 01:23:45 +1000 (AEST)
Received: by mail-lf1-x12d.google.com with SMTP id r17so22310952lfe.2
 for <linux-erofs@lists.ozlabs.org>; Tue, 27 Jul 2021 08:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pv8Xg1UA/7fyTc8laa/BULTDLowBOTs+1yEN3epTYrc=;
 b=k1rZzZE6xcYi05EXrs4BUpn5+NWrXsCgMXx9Jh7jyRxpfmdG5gGSegc1GAgHUmueGk
 zbjWmhL9vCPf6rULaA9f7eOS08DUjzTIEPuDBJdi8HHqV5MW9B3K4AtcpNnYm2C2eVmO
 +bebb5Fq/OBgJ/fbng6BdbbK2JSJkxVJD1pM3ZvukhltkIyHYkG1NJfAI6yJl8pTVnLB
 x82qUN1w6r0H0qYqjWpgypsVhaRnNAFG8W5wDI2B5U6yBh8k0UzJr7J2LgzJaAhPPJyV
 UX/qJgsbFfd4Xx8vFylNt+BPqkkbKYTbi/tPVwNfvooaMcgIK+UvAr1PXGw01DtsuLRG
 +VCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pv8Xg1UA/7fyTc8laa/BULTDLowBOTs+1yEN3epTYrc=;
 b=kJbu4WjP3oCCMvfMuwZbIE+8E8yxA4uWCJByF3tcZVk+gYkf42MtN+8hCJmEy6faoc
 UC5b6kO4viT847u902TMwGCDIVCDMphZzHh2a5CChhSGJkFeJOknkOf1sc1s4o6i/dwC
 XKMEEJUJ/mcYdPieW5TsWl+gjai82DigSawHxC3g0SIwv7SwZiudceN9NpY4e+WKFD/d
 xLcOYGvT9ya18VaRZTeYiUyfUB6MxT9LjxhZlcFZuH0RgfEdK5EaDt4/y/5FoNbQXXTT
 FjGhTZACDh1PiKBmYVRhp3b2BzGbzmgLrKmkzdvmyUUS7BUmXkqdiI2DjALNglcHpFsm
 UBkg==
X-Gm-Message-State: AOAM5339J6YDE4h9G3z+E9HbxCd/XusTvuWraanL8UcD8uLQDfeH8lnk
 hIod7vaQfmYNqbhy4qDqgCfmz7nIKMcu8OOUM2w=
X-Google-Smtp-Source: ABdhPJyVDbvQ7qncQhs4SVaYYBTv9KMgYQvTwvyKtxlDr16izB9z9m67AoqweJ0AbPriRysFKNAlhLR4SIpnStFfwX4=
X-Received: by 2002:a05:6512:70a:: with SMTP id
 b10mr16786306lfs.166.1627399418758; 
 Tue, 27 Jul 2021 08:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210727025956.80684-1-hsiangkao@linux.alibaba.com>
 <20210727151051.GH8572@magnolia>
In-Reply-To: <20210727151051.GH8572@magnolia>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Tue, 27 Jul 2021 17:23:25 +0200
Message-ID: <CAHpGcMJ2znSzZOEVZmFNDy-Yh+0HbkgRKs_jhGpRRwHUW3VxXg@mail.gmail.com>
Subject: Re:
To: "Darrick J. Wong" <djwong@kernel.org>
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
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Am Di., 27. Juli 2021 um 17:11 Uhr schrieb Darrick J. Wong <djwong@kernel.org>:
> I'll change the subject to:
>
> iomap: support reading inline data from non-zero pos

That surely works for me.

Thanks,
Andreas
