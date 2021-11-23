Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C8345AE27
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Nov 2021 22:16:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzH4h1q0Wz2yYJ
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 08:16:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20210112.gappssmtp.com header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=3UTjzt/B;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::102c;
 helo=mail-pj1-x102c.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20210112.gappssmtp.com
 header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=3UTjzt/B; dkim-atps=neutral
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzH4X1hZrz2xYK
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 08:16:05 +1100 (AEDT)
Received: by mail-pj1-x102c.google.com with SMTP id v23so534025pjr.5
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Nov 2021 13:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l+zpQrvL4Qxe/qyBBz6nO1x+ZudVJHE22cDmvcF/TOE=;
 b=3UTjzt/B58bzUMuj7IqqMnaCu5WYQAV5rK+fs5kaCfP78gUwTgy5Zlf3Be+wmIjr56
 TnFB+KlAOrzucg0BEhVOP/JXfiAUD2ftEQJXj4AikeXTgWe03Spusb/0TUld0hhFX8v6
 hoRoYhcMIe1fJGrizIl0u8fu7pfvZl0yQ6G/HZ/XblMR0kOZLIsIbaNzfqww2OtwK0QY
 M2kpeuFwFxk8ZGruQVPxMGdqTXvMTUs/jjMoa2NVuNjPrbZJxiRI6LrTQ3lIM/koJIif
 rP8I79qIKGLZ1fswpluH9sZNHRVBAzv8KTrCcmchw/ruDBCNrZVPKtgfRhQ9/KytnoiJ
 mPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l+zpQrvL4Qxe/qyBBz6nO1x+ZudVJHE22cDmvcF/TOE=;
 b=mzOq/2MUVGW3+UaEZECQFhH6Czep8TtcVDBMI1WM2pN3916LumcFm1d9RjsAiuE03T
 sWry6yPKHLyYJelcBI8MmaBZjkstr3YjW/LnaEqIfZKyACTEM49nDXNMo6t6FncC+/ZR
 qqjzA7wSoEntnyLi5vS/jYQgVb6gDwDBFqyeTq6NwYKd6GyjvdQl3qEf6STM37EXsjEa
 OH1U6OpKKCKn7e3f3oTR5c6DCfkXgtCVoAMZ2SpX3MKjH2y8umxsiaNesHfuYDm9C8qQ
 7332HtA6bA1P/cQPyp3w1EjI2AD8hEtuDEdrobJ7qUzZWfuZwjrdzQG1QCibezh7PWyJ
 Djqw==
X-Gm-Message-State: AOAM533T5nJ3DjWqHh6mGGfeCz+5DLV8sEi3mmucgXFQexyn05GnBsqC
 3cg2y0hVKuJhvUMsk8Dapjo0F7/4Mz4getOnnAyaBw==
X-Google-Smtp-Source: ABdhPJxRRlv0NZQorv0M5t2wTRvBAaxVZY2wmbRu89506wlORAkd8KhXvCTyC5EAm4rzXSOWToX/mEdJ14fdPpKfw3k=
X-Received: by 2002:a17:90b:1e07:: with SMTP id
 pg7mr494044pjb.93.1637702163126; 
 Tue, 23 Nov 2021 13:16:03 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-16-hch@lst.de>
In-Reply-To: <20211109083309.584081-16-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Nov 2021 13:15:52 -0800
Message-ID: <CAPcyv4jDqfNj4iAYoewj53QEZjXR41UuE0LN49CtC_2qjrbazg@mail.gmail.com>
Subject: Re: [PATCH 15/29] xfs: add xfs_zero_range and xfs_truncate_page
 helpers
To: Christoph Hellwig <hch@lst.de>
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
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, Mike Snitzer <snitzer@redhat.com>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org,
 linux-xfs <linux-xfs@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Shiyang Ruan <ruansy.fnst@fujitsu.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>
> Add helpers to prepare for using different DAX operations.
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> [hch: split from a larger patch + slight cleanups]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
