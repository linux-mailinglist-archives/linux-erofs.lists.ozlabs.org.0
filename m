Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB9A7268A5
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Jun 2023 20:26:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qbwm816wmz3dwL
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Jun 2023 04:26:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=PgvSlIT7;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com; envelope-from=chilversc@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=PgvSlIT7;
	dkim-atps=neutral
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qbwm06QBZz3cXl
	for <linux-erofs@lists.ozlabs.org>; Thu,  8 Jun 2023 04:26:39 +1000 (AEST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-977c88c9021so768197166b.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 07 Jun 2023 11:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686162395; x=1688754395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wODPx4uHZJHUTcdDegTDGQs4CeriK253kkjDqRsBvLs=;
        b=PgvSlIT79OUd63jjASsNr92npBtidqBIIcr0/yPjJPwrQ/113jrShII9sGfjwbYNb3
         bf1Erx4stn1BnaSvp0QRn3qhoAelcgpWg10/cZdcHU39eWCQ1zmmvFhsHckWl6Mpelo8
         UrQi0n95qJH0NgcaprsRqK9EsuGGixeScoDOcZNRWhXrxGCKSJJrifQbQDpJ/NbpAVeB
         jnMpK7MSMrzR6/c7dXnHLdH4Ep23xmPbYZOWN/75YGet+B2gqilLbPZb2Wn5na98SVuI
         dVofyri9mYj/d28wmhB/SlSfcRQFKI3N6FrMTeZxK3M2g2XCX1xe1Rxen17YsRLYapOG
         aV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686162395; x=1688754395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wODPx4uHZJHUTcdDegTDGQs4CeriK253kkjDqRsBvLs=;
        b=AZFQ+y7ZfJd0Jtizl5cDkiFkU/5W6ULIXU48fR+NQAOz7/8h2wPihkaqRioWq6ZTDT
         PfAPo9XnWoG7P5xHx4lB0N0Kjqq1MDnslzqY9wBQAhb98KqmE3vmoQU39nTGIWoFSBp5
         caQjuPVYnHsWVSOhrd1qrj5Qjtc0yVm7ka/QcWbBaU76dTzwg5kBrQBbrHKa9YplCnXN
         x62uH0uYcVMLLPunxOi5Epxtm1AEosbw6pq9AAiK+NcuN8i49e4b15ab6jfqGer3Gl1C
         gA2/jnU5blkytjRl0RnHJLNHfggW7DTZwCp6Flb6tPvv/twwnfOtqJ4xNKTDamdo0spL
         wYbw==
X-Gm-Message-State: AC+VfDxxlFeCq0loXCuLTUQlj7KAquMiVR+26ZMIsUuAXLayIVDxknPw
	7+hXXJQBQcWlRxkWfTRRwjtz8p+2QUemQzuBCKI=
X-Google-Smtp-Source: ACHHUZ4gkb4uXmtBfRalz/8gTBT4f6/AWlotdJNjgnU0y7BmJ/z28Vm/frajygWJFDgVS+dJ1qAf3w6FaHOtUUKNuBY=
X-Received: by 2002:a17:907:2d2c:b0:977:c8a7:bed5 with SMTP id
 gs44-20020a1709072d2c00b00977c8a7bed5mr7336385ejc.47.1686162395234; Wed, 07
 Jun 2023 11:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230216150701.3654894-1-dhowells@redhat.com> <CALF+zO=w2Gyz6JtzEoFgTVjH67-_CuTaK7e+2yoHEwXZ8bPx_A@mail.gmail.com>
 <CALF+zO=Y8dMsJ79RYp1e7n9B5_0=segpqW9_tetBqPhFiQcZxA@mail.gmail.com>
In-Reply-To: <CALF+zO=Y8dMsJ79RYp1e7n9B5_0=segpqW9_tetBqPhFiQcZxA@mail.gmail.com>
From: Chris Chilvers <chilversc@gmail.com>
Date: Wed, 7 Jun 2023 19:26:23 +0100
Message-ID: <CAAmbk-cBJprmRsW5uktAm49NtVw9WTLA=LPS7uLkwAknjs_1qA@mail.gmail.com>
Subject: Re: [Linux-cachefs] [PATCH v6 0/2] mm, netfs, fscache: Stop read
 optimisation when folio removed from pagecache
To: David Howells <dhowells@redhat.com>, Matthew Wilcox <willy@infradead.org>
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
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, David Wysochanski <dwysocha@redhat.com>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Any update on this? I assume it's too late for these patches to make 6.4.0.
