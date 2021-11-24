Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E494145B223
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 03:41:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzQHb1v3Gz2ypX
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 13:41:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20210112.gappssmtp.com header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=u4emMr/x;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::431;
 helo=mail-pf1-x431.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20210112.gappssmtp.com
 header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=u4emMr/x; dkim-atps=neutral
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzQHR14Q2z2yNq
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 13:41:00 +1100 (AEDT)
Received: by mail-pf1-x431.google.com with SMTP id g19so1173715pfb.8
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Nov 2021 18:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XY5RlfJ4wk969SAhdu0eeba/cRDcEGFX6BIC3EnLQt8=;
 b=u4emMr/x1DnGrylyXG/XED1B0JAzKJIqIDcJvC7Dltb93SI0bgLALNc/xx3fE/eqZ+
 JLZdSBXcBeUsE3gYFy2qkeo6t2y2XuFS7FedCduv1RHpO8vyWXlQcx11qWzGXljZ4Nta
 5OYO1lIxqTIseUFqkypGfAJj577OlmYBnt7dfkNQv9WXesT9Vr2pO7qsjUMO6hVcoGvW
 LWz11ROd5H62YcZRNEwDlvUMRryoYOk1DV1Dg4YBgp+MSllvRl7B5PMc3nehblVandHp
 KDygLbglHM1zSoblBzsW1nhsjCF5iPULo9A3DjLMb5w2hx0fDJrK0R8dTmPxHRAXcCgM
 L96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XY5RlfJ4wk969SAhdu0eeba/cRDcEGFX6BIC3EnLQt8=;
 b=yjXepGwj7WnUvBxzfy6NE4XfUGi1H8tfg1lXcAFChvBXDipNs3Q9IOkTY1O77ZVsKs
 HVT9inv4kq2A+B9E0eIgHJIEKo+P/VMii+OiNdoyVRBqHVrwD+gcTRYiYphwDeLV8Wvj
 bRVcKdH4XhCZbz4xFGJ7DaEbnjYOPJCFOd145lkyuGIJjbOc6GcbKY+xKyNc4f1o7PmV
 EvhC73mcuXcf/h3dNvXs8SX7Y3RAdO2gNDfvTsv4zzXE8lfAlwzhBvRg7NFc+wLFUZ93
 jVLkMrKpb79KB/U4twcL15BjMSiLOgqhsrCE/fThg4TEolUVSBOH90vsxMSrxtW0fYj2
 9c8A==
X-Gm-Message-State: AOAM53020Mvax1S64Mnq8MkPU0Zwll54pqt6G1wTEgXonrTf3JNnCMN3
 WkYw32y9GGgNwUtZYIyBlNrU5AGVH91o3w8t6rUWcg==
X-Google-Smtp-Source: ABdhPJzf7x9CNNO+bnTL7ccWPdJMGj5rcrJdH+gi4z67GahFamuGnCABtN5RCIhrCvjUMVb9BfOrAHDXXr0x3X1l1Pc=
X-Received: by 2002:a63:88c3:: with SMTP id l186mr1768633pgd.377.1637721658407; 
 Tue, 23 Nov 2021 18:40:58 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-22-hch@lst.de>
In-Reply-To: <20211109083309.584081-22-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Nov 2021 18:40:47 -0800
Message-ID: <CAPcyv4hY4g82PrjMPO=1kiM5sL=3=yR66r6LeG8RS3Ha2k1eUw@mail.gmail.com>
Subject: Re: [PATCH 21/29] xfs: move dax device handling into xfs_{alloc,
 free}_buftarg
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

On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hide the DAX device lookup from the xfs_super.c code.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

That's an interesting spelling of "Signed-off-by", but patch looks
good to me too. I would have expected a robot to complain about
missing sign-off?

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
