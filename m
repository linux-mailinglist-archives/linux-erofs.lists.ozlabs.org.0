Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056727E614E
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Nov 2023 01:12:44 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MEWby0EO;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SQj8930pxz3c09
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Nov 2023 11:12:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MEWby0EO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::129; helo=mail-lf1-x129.google.com; envelope-from=andreas.gruenbacher@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SQj852cmrz2yV8
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Nov 2023 11:12:36 +1100 (AEDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50943ccbbaeso377907e87.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 08 Nov 2023 16:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699488747; x=1700093547; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oxRjndTtkJZetvfezkXF/2987ikg4wY/3660b2uWMtk=;
        b=MEWby0EOFK6QPnWrtog6Xa5CuDuFANlUkTL6qB2CMXg4UdOp1l6dmMZpSQpULOzTau
         k4KKK7EfNy3r+tdMl6kw1EdiBA3tQ1VEccrjDcOBhmM9AJSiCSbYnalgCND6dMRqUPl7
         +xRF6DIxRfmWN7jAmLqk2H2cmyxooiqmQstSDNujVYB0azuu6BVv6ygzYL4MikBG7hgc
         cF0MT2rhxN9y1a8AIqjXcnFA3nrl7rBoIqkm5G+VKZNDZRYZxKFh5Iohm+EOnSt1BmK6
         l+Wuz8794uRXL1gky2lLd7PLZba08KSOaitxMUnDwAWU1nnXLwvV1BTQMyZ4KQgnGmbY
         QQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699488747; x=1700093547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxRjndTtkJZetvfezkXF/2987ikg4wY/3660b2uWMtk=;
        b=avw/i7Hl8Dyaq8S0zxBpasFuszPbmxVgPdXUgOP+4eZweUG52eOKKhE5Ir4uSKdGKl
         MhFqyWVJEOhurYGkRX8oBdKNMwpbZe65qtRA3N1n9T3xrukVbaNF8felWnWM8egfZKfg
         +Fx9SjiG/hLwH2NS9sHls03RnxECQNI9FPrDxAxX3OXLvUKwQo5cVysAhB5P59vPWC2V
         CtEeSK9du1KIDbPVTyFCOKv9/sQz641oKyxtOzQC9goR1XgUiQcqvteFp7wUFUT+9tcj
         HXp4+ZVpPGsJ7BqfueRB6RNHarH+Ydmx/wGn0PSTYUu3pIWEm2pS+fRqSX75SxEjI5Dq
         ZErg==
X-Gm-Message-State: AOJu0YxY6poVdLdCoA0VaHkDjaQwR0yLQC+IUwk9JOobh5pWbTXj1PfD
	ZuKb/EdJ91OkdMiKMeKmgLU1xTJ6XJXSFlNtdrs=
X-Google-Smtp-Source: AGHT+IGMym6s82sHBjvRZ1gVgP42jaL1JmjVcnC8voSpb7JFI9R5aRcHobWV5Dojv1Zry9WdFGNjuVaBWNGJSNkxkfg=
X-Received: by 2002:a19:6713:0:b0:508:269d:1342 with SMTP id
 b19-20020a196713000000b00508269d1342mr109419lfc.35.1699488746448; Wed, 08 Nov
 2023 16:12:26 -0800 (PST)
MIME-Version: 1.0
References: <20231107212643.3490372-1-willy@infradead.org> <20231107212643.3490372-2-willy@infradead.org>
 <20231108150606.2ec3cafb290f757f0e4c92d8@linux-foundation.org>
In-Reply-To: <20231108150606.2ec3cafb290f757f0e4c92d8@linux-foundation.org>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Thu, 9 Nov 2023 01:12:15 +0100
Message-ID: <CAHpGcMLU9CeX=P=718Gp=oYNnfbft_Mh1Nhdx45qWXY0DAf6Mg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: Add folio_zero_tail() and use it in ext4
To: Andrew Morton <akpm@linux-foundation.org>
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
Cc: linux-xfs <linux-xfs@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Gruenbacher <agruenba@redhat.com>, "Darrick J . Wong" <djwong@kernel.org>, "Matthew Wilcox \(Oracle\)" <willy@infradead.org>, gfs2@lists.linux.dev, Andreas Dilger <adilger.kernel@dilger.ca>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-ext4 <linux-ext4@vger.kernel.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Andrew,

Andrew Morton <akpm@linux-foundation.org> schrieb am Do., 9. Nov. 2023, 00:06:
> > +
> > +     if (folio_test_highmem(folio)) {
> > +             size_t max = PAGE_SIZE - offset_in_page(offset);
> > +
> > +             while (len > max) {
>
> Shouldn't this be `while (len)'?  AFAICT this code can fail to clear
> the final page.

not sure what you're seeing there, but this looks fine to me.

Thanks,
Andreas
