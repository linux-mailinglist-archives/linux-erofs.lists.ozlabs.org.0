Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EE843D8AE
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Oct 2021 03:36:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hfp7Y5nY3z2xvw
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Oct 2021 12:36:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20210112.gappssmtp.com header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=nDN9pMyc;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::434;
 helo=mail-pf1-x434.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20210112.gappssmtp.com
 header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=nDN9pMyc; dkim-atps=neutral
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hfp7H4m5mz2yPh
 for <linux-erofs@lists.ozlabs.org>; Thu, 28 Oct 2021 12:36:26 +1100 (AEDT)
Received: by mail-pf1-x434.google.com with SMTP id m26so4456258pff.3
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 Oct 2021 18:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h7Igm7cptJn/BPiAKOvXNcYjYvau2fVkwbEBPR40Qac=;
 b=nDN9pMycEij+MvvSNlzKvOXo8vpzX9jkSPwoFJ+o4gm3MZL73HDZVz6xJnzjMcbY/h
 uxqb8I8SZcSxzyFyBYzX7/LIRnqjurLkxyKCXt7vyn4OmQMNyDT08nPuKyqwzm30Iyl3
 YY7ptNRp5CFdB0o2rG3ZcydKtS+P5TBWxjp9noe/kCn6hPByhWq1BSGoPPpBqB7Delwx
 7OpBf+W0FVyg/SVq09iZbg3g6KwhgjDGpF6ftYJKhyxVAQrctr7Lax8JbvRVtA2fECbQ
 ljET309ufBhSYyMPecwX45v0eqgX6tTFFZvO7U3Ppi7VtOy0tKDgD/ePUmL2riKDB8uo
 7IaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h7Igm7cptJn/BPiAKOvXNcYjYvau2fVkwbEBPR40Qac=;
 b=fhk8FveD76KIpi7h1O53FpuDAQAQdsziQNrLrZM8oMIAXK/iaqWMvIiFb5K/zvq8pN
 FiIyoryyOL4GEWylk7HgR2yszztN3DXhu+dPvRssUmW7/G78e59kmXIqvg/QPCeEb3bf
 u0vuWXhZY9b/uNhNTAxBsMuUydswlpkrM9T3lE0GIfWcb3grgQySdxvkJIX+bWIf7HcN
 83eCQ+Q1DaHW3jU/4Rg8aKJ/qFNA2wBstM1IEs2bfkuOGE0y0LE3x+ds2/ksxXkcHpDt
 Qf2k9yodvbsNmkxQ4hJDw41kjxsiRFLhrsSkSz3IQ6OuS307TDD1H9LprDLO3/AB7ksv
 4DSQ==
X-Gm-Message-State: AOAM533mSlIxRiqdGM+n2MCVwE/Po9ZRjsxSN1L9rqzvr1Iu68NLc9MZ
 l/sahdV7W1VtRgO2iPcaf5Vd25FJLvuCf4kfCDeuog==
X-Google-Smtp-Source: ABdhPJyDv7rjKjhKzGrFppXBu1eyKYCO/S0EEDW+vfLySK20rv/agORLXNPU8PUP/nGzDZcfnIyFx3qV7wWhC+ogeBA=
X-Received: by 2002:a05:6a00:140e:b0:444:b077:51ef with SMTP id
 l14-20020a056a00140e00b00444b07751efmr1317245pfu.61.1635384983516; Wed, 27
 Oct 2021 18:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-10-hch@lst.de>
In-Reply-To: <20211018044054.1779424-10-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 27 Oct 2021 18:36:11 -0700
Message-ID: <CAPcyv4iaUPEo73+KsBdYhM72WqKqJpshL-YU_iWoujk5jNUhmA@mail.gmail.com>
Subject: Re: [PATCH 09/11] dm-log-writes: add a log_writes_dax_pgoff helper
To: Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>
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
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org,
 linux-xfs <linux-xfs@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Add a helper to perform the entire remapping for DAX accesses.  This
> helper open codes bdev_dax_pgoff given that the alignment checks have
> already been done by the submitting file system and don't need to be
> repeated.

Looks good.

Mike, ack?
