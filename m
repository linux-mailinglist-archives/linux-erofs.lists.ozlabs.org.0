Return-Path: <linux-erofs+bounces-2629-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAN0KXojsGmVgQIAu9opvQ
	(envelope-from <linux-erofs+bounces-2629-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 14:58:18 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2CD2511AB
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 14:58:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVb7V6Rc3z3bmM;
	Wed, 11 Mar 2026 00:58:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=5.189.157.229
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773151094;
	cv=none; b=ErazXr9ptsjj66UKNci2ARE8Jb1RpZHUDJfzTFumQ8ffwsCIo+3KR54gWA1yKp5A8QpQIaTPHQCbXZ124TYIx6Oiw91oPh5uqaImPvlqOJ7/7OYP5AsN4HbrBSxgzkJKlT9onZnb8pb/Ke/1CLFJ8nTmJsktRUyxd7BYnoYOXZP/crtkNDKFMCoq4L6sCx/uXE+Ho3yNkBpzGf02DXD7siyNX79veKYoUkLBiYWL+w28CsgCKa8a9g76L1griWcjhEpCDBUfeR9P0SY/XKXO5CPrl2aCwrSeD7Lsd/bjhDsPxTbHZcWLgZZ7sj4kjCCkuZXy7JuVcVYXbj3kbfQ9rw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773151094; c=relaxed/relaxed;
	bh=tqNoaL94Dj4pObM+6pGSr4RMsIJmELh6Cj7p3cxJGxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XTDtAExgLViX+jItjwJY11Au2UzQLrsJdQYK4Lu9ojRUa6ohpVEY7V3V7vsOcl4jdwmoZSCVwehDZoN8+EEuR6PjGEuGXNhRF+Jej6mS5lWfEmMD7szda6BX9xQLUO/EoeObx3RWZk0QLPojNITeC9C4BxQrjYx/EYZy+cWDq9rPqvKXooc7An3h0mWyrI9Nny2AN91Im64aXCesA3ojl0wbAxhcv1Dss4c2Q9h3YVwbuN291DEg/E5isSccLbw/xU8VytE+7ADw+VzytB4+0A3pB+n0jwnCH9x8q0ut6+C+usOxAGSPAlTgazL4KvI+HXBMjzW5mNKcJIglQVfnPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; dkim=pass (4096-bit key; unprotected) header.d=crudebyte.com header.i=@crudebyte.com header.a=rsa-sha256 header.s=kylie header.b=BSv+5VTS; dkim-atps=neutral; spf=pass (client-ip=5.189.157.229; helo=kylie.crudebyte.com; envelope-from=linux_oss@crudebyte.com; receiver=lists.ozlabs.org) smtp.mailfrom=crudebyte.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=crudebyte.com header.i=@crudebyte.com header.a=rsa-sha256 header.s=kylie header.b=BSv+5VTS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=crudebyte.com (client-ip=5.189.157.229; helo=kylie.crudebyte.com; envelope-from=linux_oss@crudebyte.com; receiver=lists.ozlabs.org)
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVb7V0h7bz30Lw
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Mar 2026 00:58:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=tqNoaL94Dj4pObM+6pGSr4RMsIJmELh6Cj7p3cxJGxE=; b=BSv+5VTSyPyrhpKWnMZVCjZEvG
	yrk6LWxlGwnUUZjquKMol+ljVUIUp9jBraubgLqBi4cKz4hniKCf9rIQTsThme1FexxEN+zxKvsgC
	uvMYbDhkYi+shFX+PLCD/IMwmjSpYMDJbZGsateoQvss1ByMiB7n5CokueqpdePTp7697ajozqLcL
	QNNNvSzTIj5kMR2wUJSupi5THJtiu7VhPmFy8ePRrdnRpYFSOebiyO3IlTbeTGO/MmRM5PEIBBHLD
	zejwvm6ItsldfqTIXTc6O0Z/soDk0el6lSZ+MrXBoszSWB5pdQE71J71rNLjrXAAIRkB6hWfEOV6d
	5s2EICAGfy5rFvZnPzPqZQFNMJmMF1OtxV9pY8V9U1rZXYRb0+cWjl6X1xLcFCZOiZcoHLob301cc
	kRokX7oWqU/2ExVyAy+qxf6eKje0uvqaOqv9hMGZ5ryaSKPC2aKAIJfnAVSBvJS/v1i4KIjPZc3rm
	OWRlN9QVYisM4o3VWUWhQE9QLOSHJzH7XsIe7kcAxjAHPZYtil03PpuGESYai0z/ycOzdMPXNnK8s
	RUYQ5R4xdnnK/uIBRJ5tLN+fwlf+9zGkqtXzZ7Db2ibQTV2JC6OBFoQ9ds8aqQ/KGsNN9Qx1u7AAn
	wqTFHtO0j/nTwkXDvMBIt3or3MQXIgQCujiNGxQ00=;
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
 Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH 06/61] 9p: Prefer IS_ERR_OR_NULL over manual NULL check
Date: Tue, 10 Mar 2026 14:45:07 +0100
Message-ID: <2401874.ElGaqSPkdT@weasel>
In-Reply-To: <20260310-b4-is_err_or_null-v1-6-bd63b656022d@avm.de>
References:
 <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-6-bd63b656022d@avm.de>
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
X-Rspamd-Queue-Id: 5E2CD2511AB
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
	TAGGED_FROM(0.00)[bounces-2629-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:amd-gfx@lists.freedesktop.org,m:apparmor@lists.ubuntu.com,m:bpf@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:cocci@inria.fr,m:dm-devel@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:gfs2@lists.linux.dev,m:intel-gfx@lists.freedesktop.org,m:intel-wired-lan@lists.osuosl.org,m:iommu@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-block@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-clk@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-leds@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-mm@kvack.org,m:linux-modules@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:linux-omap@vger.kernel.org,m:linux-phy@l
 ists.infradead.org,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-sh@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-trace-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:ntfs3@lists.linux.dev,m:samba-technical@lists.samba.org,m:sched-ext@lists.linux.dev,m:target-devel@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:v9fs@lists.linux.dev,m:phahn-oss@avm.de,m:ericvh@kernel.org,m:lucho@ionkov.net,m:asmadeus@codewreck.org,s:lists@lfdr.de];
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
	RCPT_COUNT_GT_50(0.00)[58];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo,avm.de:email,linux.dev:email]
X-Rspamd-Action: no action

On Tuesday, 10 March 2026 12:48:32 CET Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.
> 
> To: Eric Van Hensbergen <ericvh@kernel.org>
> To: Latchesar Ionkov <lucho@ionkov.net>
> To: Dominique Martinet <asmadeus@codewreck.org>
> To: Christian Schoenebeck <linux_oss@crudebyte.com>
> Cc: v9fs@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  fs/9p/fid.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

"fs/9p" in the subject on this one, please, not just "9p".

Except of that:

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> diff --git a/fs/9p/fid.h b/fs/9p/fid.h
> index
> 0d6138bee2a3d1ab565ab2d210c0a3f3bf97e4e3..3bb7ef4380e972a2d9ab67eb4aab6cc5b
> fe2eea7 100644 --- a/fs/9p/fid.h
> +++ b/fs/9p/fid.h
> @@ -27,7 +27,7 @@ static inline struct p9_fid *v9fs_fid_clone(struct dentry
> *dentry) struct p9_fid *fid, *nfid;
> 
>  	fid = v9fs_fid_lookup(dentry);
> -	if (!fid || IS_ERR(fid))
> +	if (IS_ERR_OR_NULL(fid))
>  		return fid;
> 
>  	nfid = clone_fid(fid);



