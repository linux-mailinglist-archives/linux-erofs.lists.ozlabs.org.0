Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3C02E3729
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Dec 2020 13:44:36 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D4HLT1VW6zDqC5
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Dec 2020 23:44:33 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=YOeK9t3r; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YOeK9t3r; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D4HLC6d3PzDqBm
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Dec 2020 23:44:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609159454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eNXNZbTb3NZzXN009Xt98WU8NUriNWM/XUV786DSoZY=;
 b=YOeK9t3rlMNKO2dP/62INZkG+0w/2cLDsD/cCjRMJNcUcIoh4NDf8hrJIC29kde7z/Hd7d
 zRN7vn2gp5E+IG7WnUNzXaVMSKbBdt/rCgpmflEDaVjd+OBYLAnTZ/jT+vmoVBFfQbiL79
 s/mbO8PwFHG92LPMldtLrEVncXdZajs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609159454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eNXNZbTb3NZzXN009Xt98WU8NUriNWM/XUV786DSoZY=;
 b=YOeK9t3rlMNKO2dP/62INZkG+0w/2cLDsD/cCjRMJNcUcIoh4NDf8hrJIC29kde7z/Hd7d
 zRN7vn2gp5E+IG7WnUNzXaVMSKbBdt/rCgpmflEDaVjd+OBYLAnTZ/jT+vmoVBFfQbiL79
 s/mbO8PwFHG92LPMldtLrEVncXdZajs=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-8ql-9O1EOIaN9kSssQoG_A-1; Mon, 28 Dec 2020 07:44:11 -0500
X-MC-Unique: 8ql-9O1EOIaN9kSssQoG_A-1
Received: by mail-pg1-f200.google.com with SMTP id 139so8089748pgd.11
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Dec 2020 04:44:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eNXNZbTb3NZzXN009Xt98WU8NUriNWM/XUV786DSoZY=;
 b=BSLMDGWcz6tUvunNhYi/jLu3CmlKcfiem2tCiMieX4oO6O3vgFqvWYswxchtuG/I4b
 0N+h8BlOC+sz8cphlsyNVuOIBANUawn3km3IsnsNiI4UhUPymd2Zczb6Ol5BRS5VcHXY
 U2uzE0fzXD2+/Fkmy4IehcF/viRaiBCvQt3H4UjAFrWIul0/PV7dKHk8xMo/MGMRNC+t
 AKTrYk044nLfdOhkDT9FSqn76VBz5XszKIpFYptbY5vSW6ykOhKVpMO+nnU/V0oCKKNL
 kTeOZGzoET7WZ1V+S3eW4QRqz2oN6+MbtBsOvJ3MiU1e++Ia17yyYXpbeRiKz66OYfr2
 Tv+Q==
X-Gm-Message-State: AOAM531ZTb24r0OzYY+Us5ICFlKGEGeCa4oPP3JcE6Qh96nZzI9sN8SM
 DRQCBgLzGnSGYM+LFWYKalIJEd7NXrBl47OgdxIouSkSXYWsHpC+kkasNWLh5QfAzlAqNpV3MaV
 Tlm1GJUdsFxiaVO3abv6IQBDL
X-Received: by 2002:a17:902:ee83:b029:da:3483:3957 with SMTP id
 a3-20020a170902ee83b02900da34833957mr20435831pld.38.1609159450460; 
 Mon, 28 Dec 2020 04:44:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOv6s2tpvnwx47x8qapyUX1c7891HtsfwuMjFzFhHc5k5cSgIZZgcwzPxSDQe1BU/yiDkXJg==
X-Received: by 2002:a17:902:ee83:b029:da:3483:3957 with SMTP id
 a3-20020a170902ee83b02900da34833957mr20435820pld.38.1609159450279; 
 Mon, 28 Dec 2020 04:44:10 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id s23sm20706554pgj.29.2020.12.28.04.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Dec 2020 04:44:09 -0800 (PST)
Date: Mon, 28 Dec 2020 20:43:58 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Yue Hu <zbestahu@gmail.com>, Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v2] AOSP: erofs-utils: fix sub-directory prefix for
 canned fs_config
Message-ID: <20201228124358.GB2944077@xiangao.remote.csb>
References: <20201226062736.29920-1-hsiangkao@aol.com>
 <20201228105146.2939914-1-hsiangkao@redhat.com>
 <20201228194656.000059dc.zbestahu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201228194656.000059dc.zbestahu@gmail.com>
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
Cc: Yue Hu <huyue2@yulong.com>, linux-erofs@lists.ozlabs.org,
 zhangwen@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Dec 28, 2020 at 07:46:56PM +0800, Yue Hu wrote:
> Hi Xiang,
> 
> Works fine to me for canned/non-canned fs_config.
> 
> Tested-by: Yue Hu <huyue2@yulong.com>
> 

Okay, got it. thanks you all for this :) 

(also another link for indirect call: https://lwn.net/Articles/774743/
 , so as long as some switch table, I'd like to avoid such usage...)

Thanks,
Gao Xiang

> Thx.


