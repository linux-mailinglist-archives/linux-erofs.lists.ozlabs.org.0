Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CC3459B01
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Nov 2021 05:16:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HyrRv5Kncz2yb5
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Nov 2021 15:16:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20210112.gappssmtp.com header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=wbQ/MsU1;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::102f;
 helo=mail-pj1-x102f.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20210112.gappssmtp.com
 header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=wbQ/MsU1; dkim-atps=neutral
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HyrRn0vP6z2yNr
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Nov 2021 15:16:15 +1100 (AEDT)
Received: by mail-pj1-x102f.google.com with SMTP id iq11so15533574pjb.3
 for <linux-erofs@lists.ozlabs.org>; Mon, 22 Nov 2021 20:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g/ky7DkMfynxz93Jg1Thyokk1eZpzUf1Xl2rDhRoyWA=;
 b=wbQ/MsU1SlEZ9iPye0o5lHnBo9k9LahEnJdnyRzgTrQak+nTOXkgXVWM7OQWluPbzr
 HkVEy2FdigRG5kYOuK1opEJwN/rn7TguLqcAFU7ncMwpwdXChRFN2sqd+bTf3F8BInaK
 fFwg0qsn775RNQiqooEO5yKgWsV+2wtj+cp01Q2NasJFqL66eojelACeKHvYSEfu8Xag
 ROr6vP/wogp7HYAtlyseVafxuCM7Uz2wx46f9H1VqNuffEtgZng2NeCkac5Ick13DKCh
 KqqsG7JaJle4G2RoQ9CsAKmA2/ICYEEBHwUPSN/D+pEwjOibiGCRqmiwftUbhvO4xY/f
 BPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g/ky7DkMfynxz93Jg1Thyokk1eZpzUf1Xl2rDhRoyWA=;
 b=viXnaY1eQXnodySgDBQLg0ezT8BzCLYUx7nh0P2P+qbjvNrv9xiAMIQDEJyKd6BChM
 hXcZ2divw4sDdobNUBTT6dNSAuwnJDFiLvwEpFRPX7sKVEKEuEUng955WlyUJle8aNxu
 HY7T4VXAkTzUZkQdpQAA44FGYpGT8KFq2nFixwa/1hSnPjmUfsECo2X1mkSZV1gEUCun
 mRVfdyn08vU9VixSqHnsiGCIK73VQuXI8wlQ4JWJyaPF9N3SsKCVUvM2R8+Anp5Z0kEK
 UEeLwDDKr7hq7f/UUF7+nbzVwQvbBiU1djNUdmhHvkPjqPgYUYp0ijnulcO96HEcbyHq
 GAvA==
X-Gm-Message-State: AOAM532tScwpL3blpx73Lb3DxpOblnYVRVOOQ1rpesqkT2bDJ+zhXxLm
 4IBSQvwzc4fgRTONpJ+XR234+5CtN/GXZAaGB9KHovJ6Xsg=
X-Google-Smtp-Source: ABdhPJxjpKB9AmBnKHF1Qu0JurlIqhEs9/usKwuqw/rWaPu+iQDfW+wdKRq+mST3BpRIgHuCjkJcQHKsTKAjjneenA4=
X-Received: by 2002:a17:90b:1e49:: with SMTP id
 pi9mr2831805pjb.220.1637640972493; 
 Mon, 22 Nov 2021 20:16:12 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-12-hch@lst.de>
In-Reply-To: <20211109083309.584081-12-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 22 Nov 2021 20:16:01 -0800
Message-ID: <CAPcyv4hG7npC3K-5th7qFNHuNt=dT-atUwvMEwbH_DHqzVhi=Q@mail.gmail.com>
Subject: Re: [PATCH 11/29] dm-stripe: add a stripe_dax_pgoff helper
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
