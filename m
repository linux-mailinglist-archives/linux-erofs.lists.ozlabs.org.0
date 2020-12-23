Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D59B2E1A44
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Dec 2020 10:04:18 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D16hb4C4NzDqSg
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Dec 2020 20:04:15 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=MzDnZj7O; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SCRHa3Za; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D16hW0MzszDqS5
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Dec 2020 20:04:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608714244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OaC3p3G7D+OAUePrA9tt4mZlNk2KETCOwvVfWCYaUNw=;
 b=MzDnZj7OnmtZ/ZhAvvOKGYxf01U0GAB+udcNCs0peBJi77+KOF/zztYbrW7dcjMU4UWIBv
 nw77RpYv5I1wVdkF0gLI4zIKkuLDWQ5tR9p4TnuBc1O/gkqiT4fXgvDVdI04lOCm/SZnWM
 f7pmgwjQ6abbQ5ghxbQEeXHVh9u3roE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608714245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OaC3p3G7D+OAUePrA9tt4mZlNk2KETCOwvVfWCYaUNw=;
 b=SCRHa3Za1aZ79bJxetLUmP+MbIbRrhXCPl1kogGP7gDQZ6U9MO31sS6mIDcqYSenlsmVlP
 GjDNu3K2BIp4BwG/Zbacw9YHmvTvVI1KfT3LQJ+6foKVa78pwPCZpd9SgkeSYDEc6TmitR
 GfZfjC0B6KKwm6JVqvh4l5n93YySup4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-jvnkZzc2Ngq82Wal7XYwDA-1; Wed, 23 Dec 2020 04:04:03 -0500
X-MC-Unique: jvnkZzc2Ngq82Wal7XYwDA-1
Received: by mail-pf1-f197.google.com with SMTP id 15so1825374pfu.6
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Dec 2020 01:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=OaC3p3G7D+OAUePrA9tt4mZlNk2KETCOwvVfWCYaUNw=;
 b=m10N5rwmYMvL0vYO05RLNeLZOQsow/H7n3r6AjsYzOMSgwp0S8d691008wB/KPeI12
 kxBVBE5pjg06B/mPDhyuERwjmCsVBwNK+2CVVcZUR2F+Aex8bzAwUTP7//F2+iVEOhj6
 qiElWwe50Yx0o6BT+qMmtcWmOQIzF+clO/9z8rVpmNfCs2aOYAJKdjl+vnuLbccG4Zbv
 sGS/h0yvCuqxiLZcwmg7RIUql9Zj7ecLdymPz4mI+OAn4JKOGyDtkwUgHQppLtNl5CZM
 hcjFvte0CGU0NtfOsdBxc4f+syDJ6Ana6WFHUJJgpm+lqprJUslUswLroju+9l8RphKT
 aP5g==
X-Gm-Message-State: AOAM533WqQOkl5/vkE+XE04q++N8mxCxk5i9EhTh3Wp/Vsf6/2PfhDOh
 AE/onVrgkOrno02xPjJB+fU+zv/h7UqPm4+K/okvwW2BOzCqmSFZBKifG1Do3RNDOJsdgaBKnw4
 oOgg7M797gWRja1+NMnIcQlYH
X-Received: by 2002:a17:90a:c085:: with SMTP id
 o5mr26263188pjs.210.1608714242257; 
 Wed, 23 Dec 2020 01:04:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIKfS4YxdIIJVZA9uuysC0+hLnyPpVrMJbFMUBiUUXAj0mYc5Xq/Vqz7vigPuhlVA8c9opkw==
X-Received: by 2002:a17:90a:c085:: with SMTP id
 o5mr26263176pjs.210.1608714242074; 
 Wed, 23 Dec 2020 01:04:02 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b19sm22034409pfo.24.2020.12.23.01.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Dec 2020 01:04:01 -0800 (PST)
Date: Wed, 23 Dec 2020 17:03:51 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] erofs: support direct IO for uncompressed file
Message-ID: <20201223090351.GD1831635@xiangao.remote.csb>
References: <20201214140428.44944-1-huangjianan@oppo.com>
 <20201222142234.GB17056@infradead.org>
 <20201222193901.GA1892159@xiangao.remote.csb>
 <20201223074455.GA14729@infradead.org>
 <dc4452e9-83eb-90e7-f001-d39d0ecdd105@oppo.com>
 <20201223085401.GA336@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20201223085401.GA336@infradead.org>
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

On Wed, Dec 23, 2020 at 08:54:01AM +0000, Christoph Hellwig wrote:
> On Wed, Dec 23, 2020 at 04:48:20PM +0800, Huang Jianan wrote:
> > Hi Christoph,
> > 
> > The reason we use dio is because we need to deploy the patch on some early
> > kernel versions, and we don't pay much attention to the change of iomap.
> 
> No, that is never an excuse for upstream development.

Ok, personally I also agree this, let's go further in this way.

Thanks,
Gao Xiang

> 

