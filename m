Return-Path: <linux-erofs+bounces-2643-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPNsDQv6sGkRpQIAu9opvQ
	(envelope-from <linux-erofs+bounces-2643-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Mar 2026 06:13:47 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB5B25C4A6
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Mar 2026 06:13:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVzRq60Mgz3c9r;
	Wed, 11 Mar 2026 16:13:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773206023;
	cv=none; b=kb8RhxG3IarNAQWw2UD2y/euEv5flW+UK6B/z5seEYRSv6kZOsXFJpCFdLL9yiP3NBSwFtBApywsQ53svtXN7E7PcXqN2rqsBc36XsOYKNTbewidwA3Zl7qpIH0LpRoBUXKY4yj364HEgCsgem+kBfiAZH3wiBFHGcjz5jqAw1kyYWHP6bMHPOCOWW9iRBGAQYAVGTgix/Dz9+uNpmuyte7kJCXsGx4jMEry5TOe+qek1QhI9mvRH6kMpZNq2vgP+61mJrGSpDvn6OKfhQZqCFQsRU5X1p7VDY+9LF8M/Pxo6mtccsuhdb2I0neZV0oieZ6kOLfORdFD1kNb87Z2ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773206023; c=relaxed/relaxed;
	bh=CodiYBsmL0ndtqHN7u6tywq9/pii3+ZsztJ5W7pc52A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VgbVd8u0phGK8wiBAoiLneLcVHoG+mk1HumiQuPu1FT+zeact3uI6JTIV9TCblaRLSeRtFk+9/0U6/5SDOHA8Ip/uNar1r4V6hYzME6Uwv63LwZ+hQkRK3T0qRfcKYy1y8sqLypUCgj8Ho4hQbnTyZpvAEMlbr53uJsfrQsPFVruIlwCDo1PBMTylz+q+xNsDxfqUF2aJlPPr3wtyZiBv/H980LOx2bwjrgPs3CVa/hzU5teeUIznBRY4M2QIqjkTCr7fRjha36vOA0Xos3xKWueL2wemBMkkZhcyMB3ioyHtCb6MxjfDE1hK0SNmSJVauba5UakZMkXNAdL09ubyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fBD8jk+A; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mhiramat@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fBD8jk+A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mhiramat@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVzRq02pyz3bTf
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Mar 2026 16:13:42 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8E663440BC;
	Wed, 11 Mar 2026 05:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B290C4CEF7;
	Wed, 11 Mar 2026 05:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773206020;
	bh=28by/08L5sQfVInnpnws13wBN8rSRzXkYuFZbXIDejE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fBD8jk+Az9XLzjQybetTno+W1ryvU+pJL+N7BKChPP4rEV9IYqgPEFF2K1MPy7V+I
	 icuIUfL/Dg5/kgC+Hmy6YXnokVmu1zBps2v+geMH037tafu9KbfbPBt55PGuheVQJI
	 z4qBbYgbztbgPszs8uOt3DWOo4BLsomiZb502AAVr8RGodlkXenJkrZoPQ7T4PM4Oz
	 vrK0XegnvMjvVzXWSmVe1LK/JeGbm1OZeYQWd07yKlzuY4gn+/WuMImks+j3fST4ms
	 212iplG27c78T1c+7zhxUp3BWeQ6jYmUF3g5aNFDkxAetR3pCSSickOn/0/x8U56nb
	 McVwjAbkgnZAA==
Date: Wed, 11 Mar 2026 14:13:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org,
 apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org,
 cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual NULL
 check
Message-Id: <20260311141332.b611237d36b61b2409e66cb3@kernel.org>
In-Reply-To: <20260310100750.303af303@gandalf.local.home>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
	<20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de>
	<20260310100750.303af303@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 4FB5B25C4A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2643-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rostedt@goodmis.org,m:phahn-oss@avm.de,m:amd-gfx@lists.freedesktop.org,m:apparmor@lists.ubuntu.com,m:bpf@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:cocci@inria.fr,m:dm-devel@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:gfs2@lists.linux.dev,m:intel-gfx@lists.freedesktop.org,m:intel-wired-lan@lists.osuosl.org,m:iommu@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-block@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-clk@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-leds@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-mm@kvack.org,m:linux-modules@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:linux-nfs@vger.kernel.org,m
 :linux-omap@vger.kernel.org,m:linux-phy@lists.infradead.org,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-sh@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-trace-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:ntfs3@lists.linux.dev,m:samba-technical@lists.samba.org,m:sched-ext@lists.linux.dev,m:target-devel@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:v9fs@lists.linux.dev,m:mhiramat@kernel.org,m:mathieu.desnoyers@efficios.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[mhiramat@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_GT_50(0.00)[57];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhiramat@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo,avm.de:email,efficios.com:email,goodmis.org:email]
X-Rspamd-Action: no action

On Tue, 10 Mar 2026 10:07:50 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 10 Mar 2026 12:48:41 +0100
> Philipp Hahn <phahn-oss@avm.de> wrote:
> 
> > Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> > check.
> 
> Why?
> 
> > 
> > Change generated with coccinelle.
> > 
> > To: Steven Rostedt <rostedt@goodmis.org>
> > To: Masami Hiramatsu <mhiramat@kernel.org>
> > To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-trace-kernel@vger.kernel.org
> > Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> > ---
> >  kernel/trace/fprobe.c                | 2 +-
> >  kernel/trace/kprobe_event_gen_test.c | 2 +-
> >  kernel/trace/trace_events_hist.c     | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index dcadf1d23b8a31f571392d0c49cbd22df1716b4f..a94ce810d83b90f55d1178a9bd29c78fd068df4c 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -607,7 +607,7 @@ static int fprobe_module_callback(struct notifier_block *nb,
> >  	do {
> >  		rhashtable_walk_start(&iter);
> >  
> > -		while ((node = rhashtable_walk_next(&iter)) && !IS_ERR(node))
> > +		while (!IS_ERR_OR_NULL((node = rhashtable_walk_next(&iter))))
> 
> Ug, No!
> 
> That looks so much worse than the original.

Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
But if you want to use IS_ERR_OR_NULL() here, it will be better something like

node = rhashtable_walk_next(&iter);
while (!IS_ERR_OR_NULL(node)) {
	fprobe_remove_node_in_module(mod, node, &alist);
	node = rhashtable_walk_next(&iter);
}

Thanks,

> 
> -- Steve
> 
> >  			fprobe_remove_node_in_module(mod, node, &alist);
> >  
> >  		rhashtable_walk_stop(&iter);
> > diff --git a/kernel/trace/kprobe_event_gen_test.c b/kernel/trace/kprobe_event_gen_test.c
> > index 5a4b722b50451bfdee42769a6d3be39c055690d1..a1735ca273f0b756aa1fcfcdab30ddad9bc51c5f 100644
> > --- a/kernel/trace/kprobe_event_gen_test.c
> > +++ b/kernel/trace/kprobe_event_gen_test.c
> > @@ -75,7 +75,7 @@ static struct trace_event_file *gen_kretprobe_test;
> >  
> >  static bool trace_event_file_is_valid(struct trace_event_file *input)
> >  {
> > -	return input && !IS_ERR(input);
> > +	return !IS_ERR_OR_NULL(input);
> >  }
> >  
> >  /*
> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> > index 73ea180cad555898693e92ee397a1c9493c7c167..59df215e1dfd9349eca1c0823ed709ec7285f766 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -3973,7 +3973,7 @@ trace_action_create_field_var(struct hist_trigger_data *hist_data,
> >  	 */
> >  	field_var = create_target_field_var(hist_data, system, event, var);
> >  
> > -	if (field_var && !IS_ERR(field_var)) {
> > +	if (!IS_ERR_OR_NULL(field_var)) {
> >  		save_field_var(hist_data, field_var);
> >  		hist_field = field_var->var;
> >  	} else {
> > 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

