Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8391D441E0C
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Nov 2021 17:21:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HjdZm2Hbnz2yHW
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Nov 2021 03:21:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jb2ieF+U;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jb2ieF+U;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=snitzer@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Jb2ieF+U; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jb2ieF+U; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HjdZh2Q35z2xRn
 for <linux-erofs@lists.ozlabs.org>; Tue,  2 Nov 2021 03:21:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635783689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E9idZ9g7Qiy202IHm24WOcqzjkMEWV4Amwu/3bidfKY=;
 b=Jb2ieF+UJCAXaI4awu80SUFZWF1CkD+S/ZJK/qbpHthY8oUap767smt5XzxZrVboica49v
 Gc/NLA+cN/NPFJyzzwDixs9cL1vW5tpevJ1qXmdcl2xVTclP6wi6hIsKzEOnYopmlUHAik
 6/rk9NCN9qyolMzY00bExSCWPb1mljU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635783689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E9idZ9g7Qiy202IHm24WOcqzjkMEWV4Amwu/3bidfKY=;
 b=Jb2ieF+UJCAXaI4awu80SUFZWF1CkD+S/ZJK/qbpHthY8oUap767smt5XzxZrVboica49v
 Gc/NLA+cN/NPFJyzzwDixs9cL1vW5tpevJ1qXmdcl2xVTclP6wi6hIsKzEOnYopmlUHAik
 6/rk9NCN9qyolMzY00bExSCWPb1mljU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-j19-GSIJN0GraIHtYWhPlg-1; Mon, 01 Nov 2021 12:21:28 -0400
X-MC-Unique: j19-GSIJN0GraIHtYWhPlg-1
Received: by mail-qv1-f72.google.com with SMTP id
 jo4-20020a056214500400b003a5cb094fb8so6090430qvb.22
 for <linux-erofs@lists.ozlabs.org>; Mon, 01 Nov 2021 09:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=E9idZ9g7Qiy202IHm24WOcqzjkMEWV4Amwu/3bidfKY=;
 b=uWYbMxA05mPQyY6FMlGAnRvZ2QlPTvP540VhHgyY3MdevtkUgyc9nXXjKhFlgal2TD
 abyFG6k5PfxHjQdDbmHtKL8A70mfoAMKAI8arwxv2X+l80qkcaZPXyrvQ0OSkPsMWAwz
 /CJTtsKNHFWGZCXov9A5q9D0iv8OvKbldpbn+yFP8FNvwa66vrnUcZ1s31/dbKk5f1bb
 n+HHREl5DnJvFCa0GzZEY49uVXnBx+F7TK5vqgipdfBF4GzEz84fenpU5eBHrbiATr6T
 tKHLX6BSR+zxdUyvl0Dz4ULjOL7bcM8di+pXriVBuamsO+LIrDLTU1SDhXbjyxRWImVi
 kkkA==
X-Gm-Message-State: AOAM532pvVJsnEjc4zU2Gq4xg1WtrzcZH7KmhhVrOqKiMQF35v4U7hfT
 EEq3tSWbGEe3wcMwA92/Te7Vl8UmkewfMmUHp+wZCrue+KMgLGu7XT5k/y4pFzznUBjDI6EXf53
 q5adNtJXK2+NKS3R85dHFw7Q=
X-Received: by 2002:ac8:7d04:: with SMTP id g4mr30472029qtb.183.1635783688228; 
 Mon, 01 Nov 2021 09:21:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXhGf8N2V91WU2Co6WJDyYs4GGgkn9JXnS/oEwWuG4J0RZNo7zMUQJUBh2KgjI9ZclpX5QJg==
X-Received: by 2002:ac8:7d04:: with SMTP id g4mr30472009qtb.183.1635783688071; 
 Mon, 01 Nov 2021 09:21:28 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net.
 [68.160.176.52])
 by smtp.gmail.com with ESMTPSA id bj3sm2670847qkb.75.2021.11.01.09.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Nov 2021 09:21:27 -0700 (PDT)
Date: Mon, 1 Nov 2021 12:21:26 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 10/11] dm-stripe: add a stripe_dax_pgoff helper
Message-ID: <YYAUBkiPlRCVPnyv@redhat.com>
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-11-hch@lst.de>
 <CAPcyv4iLbbqyAsy1yjFXT48D3Ssp+jy4EMJt+Sj_o2W-WMgK9w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iLbbqyAsy1yjFXT48D3Ssp+jy4EMJt+Sj_o2W-WMgK9w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=snitzer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Oct 27 2021 at  9:41P -0400,
Dan Williams <dan.j.williams@intel.com> wrote:

> On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Add a helper to perform the entire remapping for DAX accesses.  This
> > helper open codes bdev_dax_pgoff given that the alignment checks have
> > already been done by the submitting file system and don't need to be
> > repeated.
> 
> Again, looks good. Kind of embarrassing when the open-coded version is
> less LOC than using the helper.
> 
> Mike, ack?

Acked-by: Mike Snitzer <snitzer@redhat.com>

