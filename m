Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BC5454BE6
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Nov 2021 18:24:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HvVCl0GJwz2ygC
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Nov 2021 04:24:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20210112.gappssmtp.com header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=ugoMYNkh;
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
 header.s=20210112 header.b=ugoMYNkh; dkim-atps=neutral
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HvVCb2397z2xBb
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Nov 2021 04:24:03 +1100 (AEDT)
Received: by mail-pj1-x102c.google.com with SMTP id
 p18-20020a17090ad31200b001a78bb52876so5796341pju.3
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Nov 2021 09:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B1Ni0fagjZGByTTcZKwa1vZXhbm3ZKX3g7qTKHJy/9Y=;
 b=ugoMYNkhm/G9Ix/5oCvQZm0YAcysEe7w+8Ut7tdQ1MFfrFb++jT//Ye1Xif9z6ocKL
 upYEOlPYxRg426dSTkVWYqWTkYaINK0U1vjW0pz5KiVAdk24VzI9knnC+oq6VqBtR51R
 JsxZQwr6hfjAqg3NR5DXPnxzqFiDdVPzmokHwBWYbFcA7C4C1b/5vK2dlQpMEeU3BunN
 ptnIlMbRnCC/lX9LzDScYnrYijxgLzkCxo7ONiPawkK0khOy+cYFezVV1WUfTrdZx19A
 ia0nC0GD3aEx0ZtVWJVu5+3TyvxHmXgSem7quozm86z+iCZ04tmZvCRneUg4q76UfdBV
 iVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B1Ni0fagjZGByTTcZKwa1vZXhbm3ZKX3g7qTKHJy/9Y=;
 b=hl1KXxWEJ4k9c5Jk3sx5M/GcXSY11pHQZoXd1F+4VF5OBzYjAZJDXm4VfY1NZKhnff
 ///aPqprJ0JowaAKjsSB0A0NTWA0KUPwX8ukoxJPKoH/4+BermSPPcSy3YJP04pmn5y2
 8/fxzjEjqz7CI6hDGXgJM41rzJQYgzxm1BIsrRw3sBmsBQAVW2BJxkDYR5GCnQk9wV3o
 9SyweICSQKDTmriE1H8wQmUgS/839LpbvAN8mABKSXEtyYrFdTPOVBSqOd9SD4yTlK/u
 2+P4WbGCEWLI0CZIBD/fy5dSDqIh1pICIEcmsVj2jqNbpSw/cwptA32++3IGGAUFL71+
 Kxiw==
X-Gm-Message-State: AOAM532gck7N5HQXPgagqpGz28FkziIDkzwufaVvemQ2tMeUAsUei/IO
 JEsslwXECLsdtTx/XlgHfnP0Rht2l4aAVB0Dc6d3eA==
X-Google-Smtp-Source: ABdhPJxkIf4IjyDIAL/AOyg+wZo8KXg00Li3POnr9FoL4MtTk7+2uk0M9RLmtvaFQhBaLJ5ZjvKGrbUA1Og0jd55rz0=
X-Received: by 2002:a17:902:7fcd:b0:142:8ab3:ec0e with SMTP id
 t13-20020a1709027fcd00b001428ab3ec0emr56745818plb.4.1637169837229; Wed, 17
 Nov 2021 09:23:57 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-3-hch@lst.de>
In-Reply-To: <20211109083309.584081-3-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 17 Nov 2021 09:23:44 -0800
Message-ID: <CAPcyv4iPOcD8OsimpSZMnbTEsGZKj-GqSY=cWC0tPvoVs6DE1Q@mail.gmail.com>
Subject: Re: [PATCH 02/29] dm: make the DAX support dependend on CONFIG_FS_DAX
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
> The device mapper DAX support is all hanging off a block device and thus
> can't be used with device dax.  Make it depend on CONFIG_FS_DAX instead
> of CONFIG_DAX_DRIVER.  This also means that bdev_dax_pgoff only needs to
> be built under CONFIG_FS_DAX now.
>

Applied, fixed the spelling of 'dependent' in the subject and picked
up Mike's Ack from the previous send:

https://lore.kernel.org/r/YYASBVuorCedsnRL@redhat.com

Christoph, any particular reason you did not pick up the tags from the
last posting?
