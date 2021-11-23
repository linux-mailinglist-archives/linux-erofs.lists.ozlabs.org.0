Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 129E8459AA2
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Nov 2021 04:41:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HyqgM6kB9z2yb6
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Nov 2021 14:41:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20210112.gappssmtp.com header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=Y08/be2u;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::102b;
 helo=mail-pj1-x102b.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20210112.gappssmtp.com
 header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=Y08/be2u; dkim-atps=neutral
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HyqgJ3KM3z2xrP
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Nov 2021 14:41:15 +1100 (AEDT)
Received: by mail-pj1-x102b.google.com with SMTP id
 w33-20020a17090a6ba400b001a722a06212so1231827pjj.0
 for <linux-erofs@lists.ozlabs.org>; Mon, 22 Nov 2021 19:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yuisy9zT1caIpoCJEL+LfomruK38WXIi70xmI7lYDdI=;
 b=Y08/be2uy1a6FHo2yuq5V6dIERIFe+eeTyXLXTKFjFxfAYARUBwDdqRv9XulygxcF5
 4zZfKtYGqV6eckQSPyIqI+Gn3GMQFWIP9FXR6DHHwN+9GDnZm18bVZGFa88rvhT3Zhp8
 eBxG8SJu0LWqmuhUvXdN5Q8E0N7Fv2c7+1ZOSnPpTxrI3q5JIXNMGFvAj0k+TWuhQgQG
 tLoyO8DVm7L0ndxV5dBnp+whJ587dE90ANm0vqzPKJbxSHtsEtd3ERFpgMcAPItk+09G
 dbm69RRAjzWoV6a6vlvEHV0tkZfEJqiOGj5p0uoKbINk6WBGJnIFfCSAm3gIT8TG78mL
 kVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yuisy9zT1caIpoCJEL+LfomruK38WXIi70xmI7lYDdI=;
 b=k/dfrYGJOnyspHc85cS0jJv6VOCyPzPlj6jWQN4hOivPHDQEd5GqT1pA2tisCqYuQb
 yZolpI2oGXfZDNephU4WvSzn0RsLDPV9xwSPSanJbNQA7BpAf0tHHXsUilE9gtfIn41Y
 tx9rmuORT9K6zX33RlY+et1o8nhXQZiARYx3dirYXKDCsLfrxECKzjUWkzffoLnlFnb5
 ccpZvyC01FCWxrvHXl7LPksJUm3zDABwS8rUQbkNuf5CDleFTdGlQjGXFMlTdecrLg12
 56p0PmjJClUhT1SDmvz2icdbCVG6VIOMlZZmJ0SbP6XLWhf6E22Um/dRgt3MGBczqIU/
 P8mA==
X-Gm-Message-State: AOAM530Yd/yoxRdwvKjEsNXq3DzcUPZgeo7QqAqSW53wzxlSVH/jbqwh
 GhwK1/HbPJhXJkeNCVrvLjXocpx2AB8TAFfpBZ/x1BXKBiw=
X-Google-Smtp-Source: ABdhPJwgBzEQtBEEt5JgwawqvX/CZbZsaXh/qAQWeeflxeagBI6MsJ+fyqKdfOXHrkiL5G4d5gMRZlq/mNM2Mj9gTds=
X-Received: by 2002:a17:90b:1e07:: with SMTP id
 pg7mr2525502pjb.93.1637638872640; 
 Mon, 22 Nov 2021 19:41:12 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-7-hch@lst.de>
In-Reply-To: <20211109083309.584081-7-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 22 Nov 2021 19:41:01 -0800
Message-ID: <CAPcyv4imYR=NLizABpZA+gKH+amNQ6jcVNQhtF+1jyevdWzmBw@mail.gmail.com>
Subject: Re: [PATCH 06/29] dax: move the partition alignment check into
 fs_dax_get_by_bdev
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
> fs_dax_get_by_bdev is the primary interface to find a dax device for a
> block device, so move the partition alignment check there instead of
> wiring it up through ->dax_supported.
>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
