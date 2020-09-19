Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD55270AC2
	for <lists+linux-erofs@lfdr.de>; Sat, 19 Sep 2020 06:51:03 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BtdZD5Y1LzDqjj
	for <lists+linux-erofs@lfdr.de>; Sat, 19 Sep 2020 14:51:00 +1000 (AEST)
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
 header.s=mimecast20190719 header.b=KUBRpPOI; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KUBRpPOI; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BtdZ25VJjzDqV8
 for <linux-erofs@lists.ozlabs.org>; Sat, 19 Sep 2020 14:50:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600491045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V/GtNqeAhxmnaYHKbHI9s+9A7kWQV4YD44WjAsjMMwM=;
 b=KUBRpPOIEVeoQhtimD41JCXyJKfzgW8CpwzCESrq0MplN8ww08wsEbW5EG1TS6MbzU8/9a
 bSCKsmEHlO0TMuiWxzpZs50eR/LQjR1kMSxY3GE5TKrLM+O/Y1rpaRTPJXiX9NNzYSrJ6j
 CyGsv41AWERgEYbQ9ve+q2mgSonEbl8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600491045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V/GtNqeAhxmnaYHKbHI9s+9A7kWQV4YD44WjAsjMMwM=;
 b=KUBRpPOIEVeoQhtimD41JCXyJKfzgW8CpwzCESrq0MplN8ww08wsEbW5EG1TS6MbzU8/9a
 bSCKsmEHlO0TMuiWxzpZs50eR/LQjR1kMSxY3GE5TKrLM+O/Y1rpaRTPJXiX9NNzYSrJ6j
 CyGsv41AWERgEYbQ9ve+q2mgSonEbl8=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-62jpglboPXWzd7R0-qx80Q-1; Sat, 19 Sep 2020 00:50:41 -0400
X-MC-Unique: 62jpglboPXWzd7R0-qx80Q-1
Received: by mail-pf1-f197.google.com with SMTP id c197so4908303pfb.23
 for <linux-erofs@lists.ozlabs.org>; Fri, 18 Sep 2020 21:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=V/GtNqeAhxmnaYHKbHI9s+9A7kWQV4YD44WjAsjMMwM=;
 b=mS+F9XCsrnYNq2A3TGVeDCOmd1g7Iy6S8ODhOyB1dfun0rmzOAlAkF58YFfY8o3S9f
 cMlxz/gXINs1NZatcSJFDvA64aR/FDhgf5PFJ4e/muhHLzKFZERsF8vkafMnwnutJpyp
 CH57c/2qtk3sZP0C0tN5U4kYRauT6q6xegGSlGMCwquzWNLAsBCHt9pJOLYbCN083kiH
 sdb97sD8Awr5ymBtKYNmYIiVkRa21PsMfPlS5EX5CSJ2gbslH+MksGiOZnxk/FfElY3w
 kZZN8n9zx6o+PExu5oZZZ0hAhc50W58QFhdI0OasW1khdCLhC5SzC3w2z/7Noo4SgWXI
 e3JA==
X-Gm-Message-State: AOAM5309W7RhLZnw3j6KGAccJkgwwViO10+RlFIzXUNec4ywP+hzcNVW
 pHsPoIck3txDfOBV9wsT31wSmKG7Ggahp9us/dPNLXAKP9LHt6w1V34SsT6sAMXxT+ge+VtNh/s
 pqzHEjhSW3HOI1ehs3FbG7VAt
X-Received: by 2002:a63:fa45:: with SMTP id g5mr28532852pgk.448.1600491040376; 
 Fri, 18 Sep 2020 21:50:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvVI0r49m3wB0RYWnXgFPLiK9pU7OtGbcH6Hw1jnUOf70rw5kEO1Odeu56Qv8mcOKhwwSI1Q==
X-Received: by 2002:a63:fa45:: with SMTP id g5mr28532835pgk.448.1600491040079; 
 Fri, 18 Sep 2020 21:50:40 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id l188sm4898305pfl.200.2020.09.18.21.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 21:50:39 -0700 (PDT)
Date: Sat, 19 Sep 2020 12:50:29 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 3/4] erofs: specify accurate nr_iovecs for compressed bios
Message-ID: <20200919045029.GA18633@xiangao.remote.csb>
References: <20200918135436.17689-1-hsiangkao@redhat.com>
 <20200918135436.17689-3-hsiangkao@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918135436.17689-3-hsiangkao@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Sep 18, 2020 at 09:54:35PM +0800, Gao Xiang wrote:
> Use more accurate compressed page count
> instead of BIO_MAX_PAGES unconditionally.
> 
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>

Found by ro_fsstress, the submission chain could be extended
by other threads, so this patch wouldn't work with the tail
merging strategy. Please ignore this and I will drop it and
send the next version instead.

Thanks,
Gao Xiang

