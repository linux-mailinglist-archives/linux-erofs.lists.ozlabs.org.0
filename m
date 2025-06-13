Return-Path: <linux-erofs+bounces-400-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D2238AD8BDC
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Jun 2025 14:16:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bJdf8327hz30RN;
	Fri, 13 Jun 2025 22:16:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749816960;
	cv=none; b=CctcnXblmVCNV4LKtnUILCCupvTo/Sknx7g+hE9rRUveVrbYbQ566ngSWTPdeaoqD8xM2iVnumke+yKYjkLqIRZyKbCZg4FZ0QLBEmbsN/amX1qlLP25u+6frpVlADaf+grUwJgAdNCFWi0QrbNnUamBf+GSLZhZKuLp998vsNraHNjIf5CzsD+ttvK6/Akpxcw/xoScMZKG7YLezQd7m9JbzCST2qMC4+T61GTiEYdF56+LOf+wanSvBOSLAGZip97WlowXPvmnWmAqgRVEi2dCe2q7KKYRbyeO1aoDNuF9wTzOjkWvlbKmXzjgb+gtVzdbOKMb81Zjm4BvKSXsug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749816960; c=relaxed/relaxed;
	bh=HQBTQ2PbYmXrxPfeyvTXmClAKOPK7JCNSElyV1fxGrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gq1GMhIuTqx047IPUC3iabeWLbz+ryppR41QYvs/3MLh8p+Vyu/9t3bWoT0BBAQawpHbjYo5xxD5Ww7/eVt+VphQgrbAHlcTR0KOiYDJdOIMjOzqr3tw7qaVPbxd/dEzM6XidTRrARZ0Zbo8W+yx6oMlwJMroas3730Y2lFte0f0nzyeyjgo7kr8kWrAgWcQEGXrMRkYIwIjPPO+onbemvEpsGYaim/u5OzLRFoTcOZE64XKW6Efd5qQ1CiaNYgCfSQoi7yBmyp2rSIu29MoOOa7wvwd7ilNzohw6nmAJFElKnj1HgnEfZ2W8ZRINu1oANr/qdo/QmBRz419NqxuEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass (client-ip=216.40.44.14; helo=relay.hostedemail.com; envelope-from=rostedt@goodmis.org; receiver=lists.ozlabs.org) smtp.mailfrom=goodmis.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=goodmis.org (client-ip=216.40.44.14; helo=relay.hostedemail.com; envelope-from=rostedt@goodmis.org; receiver=lists.ozlabs.org)
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bJdf5525kz30HB
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Jun 2025 22:15:56 +1000 (AEST)
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 6AC841D3317;
	Fri, 13 Jun 2025 12:15:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 97F7B2000E;
	Fri, 13 Jun 2025 12:15:51 +0000 (UTC)
Date: Fri, 13 Jun 2025 08:17:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org, Gao
 Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
Subject: Re: Unused trace event in erofs
Message-ID: <20250613081728.6212a554@gandalf.local.home>
In-Reply-To: <0baf3fa2-ed77-4748-b5ee-286ce798c959@linux.alibaba.com>
References: <20250612224906.15000244@batman.local.home>
	<0baf3fa2-ed77-4748-b5ee-286ce798c959@linux.alibaba.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 97F7B2000E
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=disabled version=4.0.1
X-Stat-Signature: infzwy15dda57cgcg4d9ditmeebzkrft
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18BtDgKuXNZPoYBnFNGThqX5YGBtgfzf9o=
X-HE-Tag: 1749816951-862733
X-HE-Meta: U2FsdGVkX195zLSu+DbhYIomwGRc115YpbM2ycknmYQf2F2pGL3U8iMbkxESzO1a7e1SbWMLyeZUWsDn0+MwpfMm1VYAGVFkOGA5/0F+ZULmLOgJg6at3Pq9PTU+6HoN6Oex5p2OqUhC6tN5pyzbr5wJ8FHCNQVZQwhecbTK/s4NCZOHHD0Ya+pRdqKyIIPbYa/ojOfUFsIDt1UTwygssTgnXqGnOotPzYKO6urya1NQm4hSerex9xZqz2cCXu3Z6qygVLplU0VspUcQCoojYiWXlkM0hXc+tDg/ke4KyWpJL1U7tn9o1nOoH6kEbH/rjPoY/QCgz5/6QTutImtz/gPwSEx2bAuX
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Fri, 13 Jun 2025 14:08:32 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Steven,
> 
> On 2025/6/13 10:49, Steven Rostedt wrote:
> > I have code that will trigger a warning if a trace event is defined but
> > not used[1]. It gives a list of unused events. Here's what I have for
> > erofs:
> > 
> > warning: tracepoint 'erofs_destroy_inode' is unused.  
> 
> I'm fine to remove it, also I wonder if it's possible to disable
> erofs tracepoints (rather than disable all tracepoints) in some
> embedded use cases because erofs tracepoints might not be useful for
> them and it can save memory (and .ko size) as you said below.

You can add #ifdef around them.

Note, the "up to around 5K" means it can add up to that much depending on
what you have configured. The TRACE_EVENT() macro (and more specifically
the DECLARE_EVENT_CLASS() which TRACE_EVENT() has), is where all the bloat
is. I generates unique code for each trace event that prints it, parses it,
records it, the event fields, and has code specific for perf, ftrace and BPF.

The DEFINE_EVENT() which can be used to make several events that are
similar use the same DECLARE_EVENT_CLASS() only takes up around 250 bytes.
One reason I tell people to use DECLARE_EVENT_CLASS() when you have similar events.

There's also a DEFINE_EVENT_PRINT() that can use an existing
DECLARE_EVENT_CLASS() but update the "printk" section. That adds some more
code (the creation of the print function) but still much smaller than the
DECLARE_EVENT_CLASS(). But this requires the tracepoint function (what the
code calls) must have the same prototype.

> 
> > 
> > Each trace event can take up to around 5K in memory regardless if they
> > are used or not. Soon there will be warnings when they are defined but
> > not used. Please remove any unused trace event or at least hide it
> > under an #ifdef if they are used within configs. I'm planning on adding
> > these warning in the next merge window.  
> 
> If you don't have some interest to submit a removal patch, I will post
> a patch later.

Please make the patch. There's too many for me to do them all.

Thanks!

-- Steve

