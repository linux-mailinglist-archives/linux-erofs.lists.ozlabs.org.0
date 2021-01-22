Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3FD2FF955
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 01:19:39 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DMKdN71yVzDrWR
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 11:19:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=V0Y1nRFf; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=V0Y1nRFf; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DMKdH1XLPzDrTC
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jan 2021 11:19:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611274768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5rqXsbqGVZwIayHEc5R3AvnaK4nEGb3RrxYIPB/OcQw=;
 b=V0Y1nRFfFAnkL6GiCbjL6baaIWkouIYwdrglH0qq6pItfE1YDdTBLdodPJCepMbwC7EVMa
 ZqgCVVfGPn/i/de0ZigDHMgTjT+kqbgCz3GR45JtJrYdandrejWwaQixsInhfutMsCnBsz
 +boNgN25shy0I6xoc+4Jw347smEyJsU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611274768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5rqXsbqGVZwIayHEc5R3AvnaK4nEGb3RrxYIPB/OcQw=;
 b=V0Y1nRFfFAnkL6GiCbjL6baaIWkouIYwdrglH0qq6pItfE1YDdTBLdodPJCepMbwC7EVMa
 ZqgCVVfGPn/i/de0ZigDHMgTjT+kqbgCz3GR45JtJrYdandrejWwaQixsInhfutMsCnBsz
 +boNgN25shy0I6xoc+4Jw347smEyJsU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-RK59ZL4vP3qJ6yYbc5MJLA-1; Thu, 21 Jan 2021 19:19:26 -0500
X-MC-Unique: RK59ZL4vP3qJ6yYbc5MJLA-1
Received: by mail-pg1-f198.google.com with SMTP id 18so2266819pgf.19
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Jan 2021 16:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5rqXsbqGVZwIayHEc5R3AvnaK4nEGb3RrxYIPB/OcQw=;
 b=Y3w+FJfMzXztlx2n1SROa7CLHDJJZztJIzHTLZrLASv3BGGFmz6x8HMrYG9cXfinnH
 fRpg2jIzaF5F0Gy8pcZGys+P1h8RErFCphHe5GnYrHIcdjQMDiHsvlzYalRRrriy0+v+
 KT5tpDZOpQ91P+dcbhhMjhq4KitJZt7pdVHBrW4jOVPtjzGEheeUVt4oBLajhzZSjrkV
 6NaCUwIuhQAqBt86Ts5bwp4zu17FHPCNZaAAyXvpa354L0cQx9ZGZkyZSk6BR3iXdlQt
 qW3Cnx2eVLct3L3pAs9CDf1jiA+5pF4+nwAZPoeTT3H04HcWci/y2VsjxfXJWW29RiZw
 YiHA==
X-Gm-Message-State: AOAM533Cy29ltyssCHhJ7YAULD772Cy1xrUBjCn3iev/RDTjjtHfukVE
 8ZGcfhnGgNICbRe2Z2AixSuIauZPuiAgULYaxHUVYiXltvrSEajEavAZHztASIl59hsgJFEz94o
 Uf3iTmN+2TxuwD01lC5jrjeEI
X-Received: by 2002:a17:902:6b01:b029:da:d295:2582 with SMTP id
 o1-20020a1709026b01b02900dad2952582mr2342759plk.14.1611274764808; 
 Thu, 21 Jan 2021 16:19:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyI12O7TOtzvvxT/Ov/pRUtPW/9KaiMJxqyi4avZjL+39JfhVWmoKwXyfgz9WRLpXZzxu2PfQ==
X-Received: by 2002:a17:902:6b01:b029:da:d295:2582 with SMTP id
 o1-20020a1709026b01b02900dad2952582mr2342745plk.14.1611274764596; 
 Thu, 21 Jan 2021 16:19:24 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id m1sm7124151pjz.16.2021.01.21.16.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jan 2021 16:19:23 -0800 (PST)
Date: Fri, 22 Jan 2021 08:19:14 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Hu Weiwen <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH 2/7] erofs-utils: tests: fix on out-of-tree build
Message-ID: <20210122001914.GD2996701@xiangao.remote.csb>
References: <20210121163715.10660-1-sehuww@mail.scut.edu.cn>
 <20210121163715.10660-3-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
In-Reply-To: <20210121163715.10660-3-sehuww@mail.scut.edu.cn>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Jan 22, 2021 at 12:37:10AM +0800, Hu Weiwen wrote:
> e.g.: mkdir debug && cd debug && ../configure && make check
> 
> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>

Generally looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@aol.com>

Thanks,
Gao Xiang

