Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E6091459ADB
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Nov 2021 04:59:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hyr4Y6Vv2z2yX8
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Nov 2021 14:59:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20210112.gappssmtp.com header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=gwTsNrCE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::52b;
 helo=mail-pg1-x52b.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20210112.gappssmtp.com
 header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=gwTsNrCE; dkim-atps=neutral
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hyr4W1QTQz2xXg
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Nov 2021 14:59:39 +1100 (AEDT)
Received: by mail-pg1-x52b.google.com with SMTP id p17so17103155pgj.2
 for <linux-erofs@lists.ozlabs.org>; Mon, 22 Nov 2021 19:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g/ky7DkMfynxz93Jg1Thyokk1eZpzUf1Xl2rDhRoyWA=;
 b=gwTsNrCEoSododJW02pXoG5va8bW6OECitQWc09+sfRQX7sjnk65lMa71jflZhqZ1Z
 86aeuya1xffrx25hqOEdYvOiHJs5SgCPT9ynh1h37Y6R+YK22M+VCRKtE4fEa7B4vmJj
 FgIl1EAn3HVhHAskqaElmROImyfgrhseCNECcArK+N8mGcWyaNrHQ2uUa5SryedQ51xK
 EFHOUqysfj0ZP5ewN50SJI8X536nWAnVKZXIvFxFdkrKxXPVOOjm85CFAu2VFaD2Y1/c
 IkmhJjqPuO4/my+NrNDZVrBhbYZL7tBr4KB5P4Dw+Kdi1tW3eMcLXRLw1g/M1n7CsTvT
 3cxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g/ky7DkMfynxz93Jg1Thyokk1eZpzUf1Xl2rDhRoyWA=;
 b=ffA+lOqcqzAPkmftVUgdRMc7oIiMbCLWpKtn0rLNgREjHYkp2lCWeopxtgkqvv8+dJ
 Uk8PFGTO6vOUQpBE6WlBOVyL9rk2atquSxN08Uxi8TnDu/mVqTg8lNIy+Yhu6qoYyVMj
 bwRGLSUPwNEj9zklMIY+oTTsr/XDc2pAUxRtWRCmLGWEIKcKVEmGS0GMBpyTyhFxRORr
 UpxiwkY868XfB3eJjyLV+bQmMscv0CIZSk2ykFKwbsg6go+5pqgKDD6/QXBJetv1RCaX
 q02I5ZL4889wH4Cu3eeOMWUR/j7aHEIuBnGYMUGXzX3ZEIcUfkwBDhR6i8/BsG5Hne00
 cITg==
X-Gm-Message-State: AOAM530eBdsUrUf3VPPWhgqiu7mXPHdyZ/qejwCnis8PnwmFypA9HgFX
 9ebXH7b90QTqQTo/jiQmUXC8/wYd6fiufOyGjGrS/g==
X-Google-Smtp-Source: ABdhPJwGHnABHnUK3lJPgD02NSEK0H2EfeyLizUEIRr93I6wp+H8p3N47d3IhUfBHGyYAjrqraEpCA3HamH0r9lHbyI=
X-Received: by 2002:a63:85c6:: with SMTP id u189mr1546658pgd.377.1637639976375; 
 Mon, 22 Nov 2021 19:59:36 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-10-hch@lst.de>
In-Reply-To: <20211109083309.584081-10-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 22 Nov 2021 19:59:25 -0800
Message-ID: <CAPcyv4igxMdMA0XpjZt0aXahef5Worvz663ynd5i4=HeKJAqKw@mail.gmail.com>
Subject: Re: [PATCH 09/29] dm-linear: add a linear_dax_pgoff helper
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
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Nov 9, 2021 at 12:33 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Add a helper to perform the entire remapping for DAX accesses.  This
> helper open codes bdev_dax_pgoff given that the alignment checks have
> already been done by the submitting file system and don't need to be
> repeated.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Mike Snitzer <snitzer@redhat.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
