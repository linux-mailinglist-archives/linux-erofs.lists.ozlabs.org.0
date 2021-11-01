Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B6A441DCF
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Nov 2021 17:14:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HjdQN6JPwz2yJ2
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Nov 2021 03:14:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BmFObHBK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HkcWOoMD;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=snitzer@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=BmFObHBK; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HkcWOoMD; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HjdQC3gSBz2xY6
 for <linux-erofs@lists.ozlabs.org>; Tue,  2 Nov 2021 03:14:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635783248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+G6SzjVTR+LCyYNlG0zbcp2+gduPxDNU+2Zc+nwBRpo=;
 b=BmFObHBKnXlX3x8T+S8igltipJCZ+z/U2c2pg5UsvGtJJwPDBrnGICnfuajB4nbC721/Lo
 N3ESjOdMvj0q/UsDAisQ2lyU7gPUjaFvTFnkljuGfZ0Qd0RUJ3lTR2/L0tnQw0yaUv0TXU
 DY49lr27MbfcCCjHUR+4mRNqp5RQtMI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635783249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+G6SzjVTR+LCyYNlG0zbcp2+gduPxDNU+2Zc+nwBRpo=;
 b=HkcWOoMDgq5dKe2oPRbUNNy03asuFTbg23R9sZ/JGi+BaC7HHbFE+lV4X34IgERrNJ7/mj
 lnxsY7akEOeu23+N/yKsF8y723v5NrF0uxkJ2f8QkcCtcEWHlj8ka/eZvju/ey40KGnXA4
 b68vczJQe/Nc7J+nxPV5t6bTEhbUvgw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-zoQqE6FMOi2VJxMy9vDjCA-1; Mon, 01 Nov 2021 12:12:55 -0400
X-MC-Unique: zoQqE6FMOi2VJxMy9vDjCA-1
Received: by mail-qv1-f69.google.com with SMTP id
 q9-20020ad45749000000b00382b7c83aa1so16734050qvx.11
 for <linux-erofs@lists.ozlabs.org>; Mon, 01 Nov 2021 09:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+G6SzjVTR+LCyYNlG0zbcp2+gduPxDNU+2Zc+nwBRpo=;
 b=mkNVeiAYMLxxbD3CfeyWI3sccYSZkwXbvx7tIWBkhZpZn87KLEg09qzKzsVqagpIge
 +/eIRnxjMjFovQujZfWJsO7x11IUvxCedJGeSOH43Ku9W2xu5U+uoIWy/hu227/HUl5Q
 MiygL3e4eTdHsYCKp2BekhtvQOeQaMPIY2TJQ773vVcJ5iKZdwMEAKnVuLNlXEoK/hCJ
 ZDKQ/k5PSAU8nJwzN+xjQYdh3z/2PPMp2sQMx7xgsIPT6Jh/Ces22xNq5q349aH6VeRl
 sfSfZqGL/xOqZ3yoWO2I1XvYTH6D1rIsj7rXHOrR59H+O3ikmFH7ufL/ZC9QhkBarASP
 2SNQ==
X-Gm-Message-State: AOAM531D3dnSb8poXIPUU8m8ZDRSB2ITtECSsKJxmUYy9WWSvkz20bQn
 +fZSIiNAG+BcL5ndSKSMb1WS3geJPc1uxCdhdgahuBH6E/hoGa2Jpffn5AukUkJim89FFixI8pN
 oXo21md8hepXIm/BMOxeF6tI=
X-Received: by 2002:a0c:e708:: with SMTP id d8mr23264793qvn.62.1635783175419; 
 Mon, 01 Nov 2021 09:12:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/H7B1fdn7PP13//AwKmpta1av9FRTtOajPRoBskVHgoJcCnXd+0D44u/s4udzcALoTqA+Rw==
X-Received: by 2002:a0c:e708:: with SMTP id d8mr23264758qvn.62.1635783175189; 
 Mon, 01 Nov 2021 09:12:55 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net.
 [68.160.176.52])
 by smtp.gmail.com with ESMTPSA id v16sm167031qtw.90.2021.11.01.09.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Nov 2021 09:12:54 -0700 (PDT)
Date: Mon, 1 Nov 2021 12:12:53 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 01/11] dm: make the DAX support dependend on CONFIG_FS_DAX
Message-ID: <YYASBVuorCedsnRL@redhat.com>
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-2-hch@lst.de>
 <CAPcyv4hrEPizMOH-XhCqh=23EJDG=W6VwvQ1pVstfe-Jm-AsiQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hrEPizMOH-XhCqh=23EJDG=W6VwvQ1pVstfe-Jm-AsiQ@mail.gmail.com>
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

On Wed, Oct 27 2021 at  4:53P -0400,
Dan Williams <dan.j.williams@intel.com> wrote:

> On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > The device mapper DAX support is all hanging off a block device and thus
> > can't be used with device dax.  Make it depend on CONFIG_FS_DAX instead
> > of CONFIG_DAX_DRIVER.  This also means that bdev_dax_pgoff only needs to
> > be built under CONFIG_FS_DAX now.
> 
> Looks good.
> 
> Mike, can I get an ack to take this through nvdimm.git? (you'll likely
> see me repeat this question on subsequent patches in this series).

Sorry for late reply, but I see you punted on pushing for 5.16 merge
anyway (I'm sure my lack of response didn't help, sorry about that).

Acked-by: Mike Snitzer <snitzer@redhat.com>

Thanks!

