Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 111CC2E0F00
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 20:39:27 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D0mqw0sWfzDqR2
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Dec 2020 06:39:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=CLLCPN8T; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CLLCPN8T; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D0mqs5YQHzDqNw
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Dec 2020 06:39:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608665956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5tsCMd9Nfdq9n0ayDvsC2lk0uNSEwrw9mxvuZSf1qkQ=;
 b=CLLCPN8T7hKW+8W3WWhyncblrJqfdtSbujItlrXA+/Dh5aY7sH4vB6VdQhUJLmWhHYiHZT
 GMECVO12LglnFgd1oL+frWP40jDSPCz0qmAtEa+Wo+H6ihYfHLb9YeJ9QZmB2ThUbq+M/w
 Eg7tWfrLSQ/vdf+cRvfJJrHRnBl9Kv4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608665956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5tsCMd9Nfdq9n0ayDvsC2lk0uNSEwrw9mxvuZSf1qkQ=;
 b=CLLCPN8T7hKW+8W3WWhyncblrJqfdtSbujItlrXA+/Dh5aY7sH4vB6VdQhUJLmWhHYiHZT
 GMECVO12LglnFgd1oL+frWP40jDSPCz0qmAtEa+Wo+H6ihYfHLb9YeJ9QZmB2ThUbq+M/w
 Eg7tWfrLSQ/vdf+cRvfJJrHRnBl9Kv4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-TBExDzjWN7eWFZ-6OLu2iQ-1; Tue, 22 Dec 2020 14:39:13 -0500
X-MC-Unique: TBExDzjWN7eWFZ-6OLu2iQ-1
Received: by mail-pf1-f200.google.com with SMTP id r15so7301773pfg.5
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 11:39:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5tsCMd9Nfdq9n0ayDvsC2lk0uNSEwrw9mxvuZSf1qkQ=;
 b=m4GZ3s8GbNKQFre9g/o/LVFuYRaPltCJsI4F5nkRT3fYE11cq3hPUTmEgClXoiZb/p
 hKcJoRKaaTp5C9Ffj6gaCnxdfL+JX7YQItnIR/V6WXkEIikjoomxBlGr73dn445eCHcb
 s35E6+QFIZ+ba+maKWbRuZWUEl7m0M2Ydnf8CoxiNu/kGwk6+WcBNHlXYW+lgUQZNc3o
 hlIkT+if0xufSfSd4hIyCU3Lt/RM1SuPNzzWTb/+H/GJPRYYeCkONJng/KvRtf0IV5Hn
 WOG9CJQvj6I/6wCVUfGhO7W3PvDdc18k+JHQgZk4du5zmL9Cr9j3c7JdpK+IkY3LGL4o
 8nLA==
X-Gm-Message-State: AOAM531B26ryYJgOOKCPYgkaOvV8n+5MuNhSX+tXA+sPvg4WYhIhwSdr
 RJ3epWwt+0lYoneDZNaTnPgAmAuIRFUNkplga3ckwizBO95Pa/Jki3aLUlVkFVGCgYQrUdIbZuA
 eUEfe7WHPGTEZ8ey+xHcXoOMR
X-Received: by 2002:a62:7857:0:b029:19d:fe6a:3069 with SMTP id
 t84-20020a6278570000b029019dfe6a3069mr21223282pfc.3.1608665952719; 
 Tue, 22 Dec 2020 11:39:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxiytS6W//zDGdZqsS2j37qTS3snbiPRUfNBd0oZl7T0AOd+Z8EYMV0Xj4leWnaUJxCM0pRgQ==
X-Received: by 2002:a62:7857:0:b029:19d:fe6a:3069 with SMTP id
 t84-20020a6278570000b029019dfe6a3069mr21223273pfc.3.1608665952512; 
 Tue, 22 Dec 2020 11:39:12 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 7sm21372646pfh.142.2020.12.22.11.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Dec 2020 11:39:12 -0800 (PST)
Date: Wed, 23 Dec 2020 03:39:01 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] erofs: support direct IO for uncompressed file
Message-ID: <20201222193901.GA1892159@xiangao.remote.csb>
References: <20201214140428.44944-1-huangjianan@oppo.com>
 <20201222142234.GB17056@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20201222142234.GB17056@infradead.org>
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
Cc: linux-kernel@vger.kernel.org, guoweichao@oppo.com,
 linux-erofs@lists.ozlabs.org, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christoph,

On Tue, Dec 22, 2020 at 02:22:34PM +0000, Christoph Hellwig wrote:
> Please do not add new callers of __blockdev_direct_IO and use the modern
> iomap variant instead.

We've talked about this topic before. The current status is that iomap
doesn't support tail-packing inline data yet (Chao once sent out a version),
and erofs only cares about read intrastructure for now (So we don't think
more about how to deal with tail-packing inline write path). Plus, the
original patch was once lack of inline data regression test from gfs2 folks.

The main use case I know so far is to enable direct I/O and leave loop images
uncompressed for loop devices. And making the content of the loop images
compressed to avoid double caching.

Personally, I'd like to convert it to iomap infrastructure as well. So if it
has some concern for __blockdev_direct_IO as an interim solution, hope that
Jianan could pick this work up. That would be better.

Thanks,
Gao Xiang

> 

