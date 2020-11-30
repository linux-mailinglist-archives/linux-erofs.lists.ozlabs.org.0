Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 433222C8DA2
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Nov 2020 20:03:01 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ClF4164vJzDqx4
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Dec 2020 06:02:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=A2x2n5xA; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZoKLYmSJ; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ClDvD0zBHzDqSw
 for <linux-erofs@lists.ozlabs.org>; Tue,  1 Dec 2020 05:55:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606762513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UJa4+nJnAblt3hEvp+SYFJg8d4mfG8f2+fFVNZQWsaA=;
 b=A2x2n5xACs4P3anGbM3r9qO8JY8Ni+I6km71IKLZvFfA8DlOI17Ziqmo7ifiXlVh+3Em46
 MfkBJCh1rOICEkK7J57Z8eAiVG2glOS1alG0nhgXthxqxmPFU1TfE+WUrmtBe3Y7bmU67y
 wnmL6Mz+tiYjW4yfu8ppLdR0E/ZT3+Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606762514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UJa4+nJnAblt3hEvp+SYFJg8d4mfG8f2+fFVNZQWsaA=;
 b=ZoKLYmSJ7pzNnX8q+1mPZXCjcrVOSHVXFAYgyijkxPg6AH0qxnlQKMzyhF56fdZIZJ3UXF
 jqD9d7SZE55xAbEVzrRt1p9AqIpI/iK+v5RX3CN+4fnvSRP7vbPhivi2PeOBdPjyVkLxI6
 n/fy3Cjo6qOECJX3yQQ8Bnrb+wWUZ64=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-Gh5hP0yqP0qVP4zku5jqdQ-1; Mon, 30 Nov 2020 13:55:09 -0500
X-MC-Unique: Gh5hP0yqP0qVP4zku5jqdQ-1
Received: by mail-pf1-f197.google.com with SMTP id a24so9702398pfo.3
 for <linux-erofs@lists.ozlabs.org>; Mon, 30 Nov 2020 10:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=UJa4+nJnAblt3hEvp+SYFJg8d4mfG8f2+fFVNZQWsaA=;
 b=lyELzYpIDQfYdgUnT8V9mn2aTTOG9/Z6rvq4fnnow/uDB+stGqMIaNotEJQf4oYTye
 EfJ/dCleIotMLOIJaGrPSrUW1J0gmrVTPiJKzgMA5zSVgAXzBXhX3zGyew3u+Cudi4CE
 wNKvxNzsc/L5Dt5eFF4HEmVVYDkbRzH2kBhAUXji/ZGJZvrMFUBufU3vKZIVl5FOR2OW
 eqyUMTNU8Wdybb7Vqh8edRhSIdo0fudMJPo6oEmw4RmVvw23FHjsQWwDzwAz3+zcLMuf
 SPufCpcMDNNj3eW3/K9ITqwCR5+vR50/3Wt2niFNn/SfSvD7goxuDKmECOHYi0z6bdQ2
 PphQ==
X-Gm-Message-State: AOAM533u1E5B4+lmr44ngcV1oXDjNiH/l3HilGJ0Vgnn86IshTn70gPb
 +QYhQDcdqyaTXzOJDiOe7mOyykMO1Rp9+3U/ybEIvcFVCw8iCq4onIia71hFSwfhGx3qx2yPoyu
 5v0cgBj78oBkZAih3f/p7Z+Na
X-Received: by 2002:a17:90a:9e5:: with SMTP id 92mr266226pjo.176.1606762508473; 
 Mon, 30 Nov 2020 10:55:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5XFm0e2WR2j2Oq/bqCs2+nYMpHE7WhzMfpV9dzDeIzdQJd1QvcKUNaxxdTuILeH2k+sDZ1w==
X-Received: by 2002:a17:90a:9e5:: with SMTP id 92mr266195pjo.176.1606762508227; 
 Mon, 30 Nov 2020 10:55:08 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z11sm187039pjn.5.2020.11.30.10.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 10:55:07 -0800 (PST)
Date: Tue, 1 Dec 2020 02:54:55 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Nick Terrell <terrelln@fb.com>
Subject: Re: [PATCH v2] lib/lz4: explicitly support in-place decompression
Message-ID: <20201130185455.GA1181636@xiangao.remote.csb>
References: <20201121191024.2631523-1-hsiangkao@redhat.com>
 <20201122030749.2698994-1-hsiangkao@redhat.com>
 <73E0BBBC-434D-4877-8E43-F995F8F4FE25@fb.com>
MIME-Version: 1.0
In-Reply-To: <73E0BBBC-434D-4877-8E43-F995F8F4FE25@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>, Yann Collet <yann.collet.73@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Nov 30, 2020 at 06:19:34PM +0000, Nick Terrell wrote:
> 

<too long snip>

> 
> Looks good to me! You can add:
> 
> Reviewed-by: Nick Terrell <terrelln@fb.com>

Thanks for reviewing this!

Thanks,
Gao Xiang

> 

