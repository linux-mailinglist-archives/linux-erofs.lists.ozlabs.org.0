Return-Path: <linux-erofs+bounces-2627-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLfWOeUgsGmCgAIAu9opvQ
	(envelope-from <linux-erofs+bounces-2627-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 14:47:17 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2B7250C5B
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 14:47:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVZtp4xB8z3bjb;
	Wed, 11 Mar 2026 00:47:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=5.189.157.229
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773150434;
	cv=none; b=Hayzr6/KnOMFOTSC1RSa5g62iP1LSseiYqWb3UguS/UKPIJMiF5wRIV0TWIz6JMXqPCTloN4CJl+fcMl3130S8uUjFiSP1TXCF7yXP1so1nFO/hl9zzFoeT+9C6Fml1uUnWYBgC5MHe/H4ZGoHqQduds8e6xxG+WHo5C9BnUR0b4mGwRYrgTKtvu6WzANLHr8M1t+iGYBPb2fF9qF0skR0E9C6mkfnHB9owTZLaPrEiwoeKf8KSLemk9e2U2L3VYEBRNa/8g/8JEcidrCskFYuKSEC4vaU0UIKBoKM+b40Q2Bb5PoxtcxcnYOhw38HotedgEqBzxE+CR4+m0a5hwVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773150434; c=relaxed/relaxed;
	bh=aVv/PSZT5NGeZjfHxwg8OpWgNHlsgZDJ/5CMzeiUbdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oVK7IqCjjyhccyfKEUknUPVIux1/jGjYgQwLoD+KswEfd9M1Uc0eT/DRStvBKECSWY34mLL8v0bfaWgu8iWpTqDMQRQg7GMwmgV6PbbzP928IfQwHIAvHlSN5HHtEA2d2sX9qgRybdBnYhZ/oLfCNnuQ9g9cvZa/rmGx0vUGcA4j7BMqgmoFBw0wQBOncybd9ig7YOi6iF4i91eDLdhN9T4Mq2p8xhKwv+hn2t+8HmhF02fq3G8/9rotOVED5DEzKSYp+cJkpF0mNvSdJDW7gctvAtEFIX11Cn/1Fk4xZnkQnMyUijaKJFY6oc9p9gly22ECAcqjcGC4+bjqcx7MTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; dkim=pass (4096-bit key; unprotected) header.d=crudebyte.com header.i=@crudebyte.com header.a=rsa-sha256 header.s=kylie header.b=dTpIUmFy; dkim-atps=neutral; spf=pass (client-ip=5.189.157.229; helo=kylie.crudebyte.com; envelope-from=linux_oss@crudebyte.com; receiver=lists.ozlabs.org) smtp.mailfrom=crudebyte.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=crudebyte.com header.i=@crudebyte.com header.a=rsa-sha256 header.s=kylie header.b=dTpIUmFy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=crudebyte.com (client-ip=5.189.157.229; helo=kylie.crudebyte.com; envelope-from=linux_oss@crudebyte.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 110 seconds by postgrey-1.37 at boromir; Wed, 11 Mar 2026 00:47:13 AEDT
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVZtn3KKwz3bmM
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Mar 2026 00:47:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=aVv/PSZT5NGeZjfHxwg8OpWgNHlsgZDJ/5CMzeiUbdo=; b=dTpIUmFyfV+bP6Hy0ueZpN32tu
	piiOrm2xYxIB724JO1nPYEvLrwNppM7ldi2VsLNiB9a22ZPzaNJQ0YaGHJwVuraOF2yk5SpAHZold
	s8t7GSMCpZMXoj2MN+HCYF9oJcPgVF+TLl3oulmGF4t7YrhkwJ3IfsTmzXldUh96w/myd3pDSVX1g
	/e8bzPXWMBYBNoEloTPI5IYSewDyrYj60Js0etFfclp4hEgkn7HaHPBIdN5mmqp8OC3Z4JyMZY1In
	us3k02cy2EDC8Yr2DD9TZj2Bfv2JCzi8o1CBU/q/X+4deOd5/tymAnt0Bem3HGOfb0TZNQXc+sRV/
	1upKIM10UX7QbQ98BeJxn1cHAUt80a13aLlrns2kgX3r4ZD43IvQ3qOgYizweNeHFZvB+bpwBSNFD
	hlDW1qIdKmIN+wC7qSL6cU7m+YgH+eIF1AeR8pLLvTFBNqmI6qti9D+O96RBcbYAwE/olpfjlTGn5
	mdLSL9FFfI7mx4Sepl5WAdeD1XVerb2KTcAMA8AXYimzng7DssEnPDbX6u+t3yAcQjc1BrWIujZyx
	Gao2D20IgKGUx784nxNUpYJ2ZiCkXzoDKyugnEIdTC+VrOwC2OEJanP1Uq3/BrGj0qOrmxYFeI51c
	48zjYWWU3v40e6itkF189TkI8Acs6/RLaheNlL7MM=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org,
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
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
 Philipp Hahn <phahn-oss@avm.de>, Philipp Hahn <phahn-oss@avm.de>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Subject:
 Re: [PATCH 24/61] net/9p: Prefer IS_ERR_OR_NULL over manual NULL check
Date: Tue, 10 Mar 2026 14:47:03 +0100
Message-ID: <1948861.tdWV9SEqCh@weasel>
In-Reply-To: <20260310-b4-is_err_or_null-v1-24-bd63b656022d@avm.de>
References:
 <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-24-bd63b656022d@avm.de>
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
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 2A2B7250C5B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.30 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	CTE_CASE(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crudebyte.com,quarantine];
	R_DKIM_ALLOW(-0.20)[crudebyte.com:s=kylie];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:amd-gfx@lists.freedesktop.org,m:apparmor@lists.ubuntu.com,m:bpf@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:cocci@inria.fr,m:dm-devel@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:gfs2@lists.linux.dev,m:intel-gfx@lists.freedesktop.org,m:intel-wired-lan@lists.osuosl.org,m:iommu@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-block@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-clk@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-leds@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-mm@kvack.org,m:linux-modules@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:linux-omap@vger.kernel.org,m:linux-phy@l
 ists.infradead.org,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-sh@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-trace-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:ntfs3@lists.linux.dev,m:samba-technical@lists.samba.org,m:sched-ext@lists.linux.dev,m:target-devel@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:v9fs@lists.linux.dev,m:phahn-oss@avm.de,m:ericvh@kernel.org,m:lucho@ionkov.net,m:asmadeus@codewreck.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-2627-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[linux_oss@crudebyte.com,linux-erofs@lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[crudebyte.com:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[linux_oss@crudebyte.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[63];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[avm.de:email,linux.dev:email,crudebyte.com:dkim,crudebyte.com:email,ionkov.net:email,lists.ozlabs.org:rdns,lists.ozlabs.org:helo,codewreck.org:email]
X-Rspamd-Action: no action

On Tuesday, 10 March 2026 12:48:50 CET Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.
> 
> To: Eric Van Hensbergen <ericvh@kernel.org>
> To: Latchesar Ionkov <lucho@ionkov.net>
> To: Dominique Martinet <asmadeus@codewreck.org>
> To: Christian Schoenebeck <linux_oss@crudebyte.com>
> To: "David S. Miller" <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Simon Horman <horms@kernel.org>
> Cc: v9fs@lists.linux.dev
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  include/net/9p/client.h | 2 +-
>  net/9p/trans_rdma.c     | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
 
> diff --git a/include/net/9p/client.h b/include/net/9p/client.h
> index
> 838a94218b593f3fb19e6827c472753380193461..4bde6bd716f323c819745e64c7aac0dea
> 7beb72f 100644 --- a/include/net/9p/client.h
> +++ b/include/net/9p/client.h
> @@ -364,7 +364,7 @@ static inline struct p9_fid *p9_fid_get(struct p9_fid
> *fid)
> 
>  static inline int p9_fid_put(struct p9_fid *fid)
>  {
> -	if (!fid || IS_ERR(fid))
> +	if (IS_ERR_OR_NULL(fid))
>  		return 0;
> 
>  	if (tracepoint_enabled(9p_fid_ref))
> diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
> index
> aa5bd74d333f3b5e6fd1e4344d26bc0201ff7f7f..60461344b536bcb6e94112aace75a88b6
> a99ad86 100644 --- a/net/9p/trans_rdma.c
> +++ b/net/9p/trans_rdma.c
> @@ -252,16 +252,16 @@ static void rdma_destroy_trans(struct p9_trans_rdma
> *rdma) if (!rdma)
>  		return;
> 
> -	if (rdma->qp && !IS_ERR(rdma->qp))
> +	if (!IS_ERR_OR_NULL(rdma->qp))
>  		ib_destroy_qp(rdma->qp);
> 
> -	if (rdma->pd && !IS_ERR(rdma->pd))
> +	if (!IS_ERR_OR_NULL(rdma->pd))
>  		ib_dealloc_pd(rdma->pd);
> 
> -	if (rdma->cq && !IS_ERR(rdma->cq))
> +	if (!IS_ERR_OR_NULL(rdma->cq))
>  		ib_free_cq(rdma->cq);
> 
> -	if (rdma->cm_id && !IS_ERR(rdma->cm_id))
> +	if (!IS_ERR_OR_NULL(rdma->cm_id))
>  		rdma_destroy_id(rdma->cm_id);
> 
>  	kfree(rdma);



