Return-Path: <linux-erofs+bounces-2263-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMWoAmFghGng2gMAu9opvQ
	(envelope-from <linux-erofs+bounces-2263-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Feb 2026 10:18:25 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A3222F07FA
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Feb 2026 10:18:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6BTm6ZB5z2xrk;
	Thu, 05 Feb 2026 20:18:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::329" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770283100;
	cv=pass; b=Bccoe6Imjk3uf9fChxZqohuem/1QeLHItbAabtrC9ojaOWkoTPKusIdG/WlnnEFBScTgPkJ3hHAL77ZxqmnunNMFEL5Pob6B6NHDZESnuRx2xGxoXBKslg5l7NGdS6YLMA+EEe13XuFXZZ7/8V44xvDWRSjTsgvzDdSUxH/Z0jlqH/H8+4JqiAnFlQ4tKLlaFyAZ0FNCacLthqNY5SRb41Q0G1ep2+tktHq9HmgAFOaMsIq7n5uzxVVsjjCgj6jGWyo26LegBGGhhD6R3WQbz+ClWxTgjZlsKIKp/PZN8FoAaVKrMD4ig6jfZV/OdiO66Fe+3R3MeIMNIHPW+KgKzQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770283100; c=relaxed/relaxed;
	bh=y7X94wcwqmm+LoFVA6eziIi5H+WCfNRJwZLfGEBUYiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6ZP2slVocramvAmnFZqA5I+gZj39TKZVa0EKd8zqEFk/5o1DQdQmer/tAXTnP1Dyb3XsM+5wxblPM39EUnrReqCqXc7qf2/diHZKGFSJym8Yin2hMQxDNL8hu0JFKQU4V6spBAjpagx8sKC1kNWS/aotgpdxdyqaBseZ5/fo7gjYyVRsBbo3n/m3yFbsPATeSVz3P7ZmpfxRXvar+dAVIaOj/4vilJryyrHdGEQxvPprFITCv/ypADfGT43PGYu/7fnB2iZs7Mp4LQCrrk42ZuGuQYlM6fF2tjBFCj7U5ADhTHGU8rQXhAsMGOFqINghbFXFH4igjSLRyEfpkDhgQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=R3jr4oO0; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=niuzhiguo84@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=R3jr4oO0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=niuzhiguo84@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6BTl0Ts3z2xg9
	for <linux-erofs@lists.ozlabs.org>; Thu, 05 Feb 2026 20:18:18 +1100 (AEDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4806b88d8c9so1059105e9.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 05 Feb 2026 01:18:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770283090; cv=none;
        d=google.com; s=arc-20240605;
        b=c/69kkIMltgqsLiH7KtFzMnKCuIVSbad3ZNS4kzsyM7NObGgeSm+c+Ip3rsdzKIXkf
         y0v2yCCIwT4H+s2CvtebJJQNITttGYbxVgU4BvExfJ68AQnRnea/C9VtV62dm27eiN7l
         v6kHkx0PMy7CyavsIEwxXmFC6Z6Jn+KFRRCuxcCg6HLpAFOxBc6SISqMIA6HrkSrlIvP
         vEfqxiUG93QPrC7JydGQW0QiDxBcMcT2eYyw2AcKZJuv442wLfMqMXcm9Nmsc5FsGNn6
         Rfz3leIe7lWRsdXve4hHXTVyanCfv4pmp41x+22pFCKHBuTY7EVMKRQXqeAyZV3aeSrt
         Zfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y7X94wcwqmm+LoFVA6eziIi5H+WCfNRJwZLfGEBUYiY=;
        fh=RMbxb9YLKVxTavq/77XMAKTB24UO0J5hr0K1ARWGDxo=;
        b=SwWgeR/vAIBMI2BpuRrw8Em11FaMOMRbHMUiwEcMHigFG0ugno86h0hfm8G0hZW8EW
         25bUPcwASwvKM3LnjQ1lYasvylFEIx/LOxqyWlbvz2QnjWSGaJdB57IrMY7bRaohLFMd
         AwzsEUl1nteMd3//Wb1Q47AVnS7sNSs596QakuBUBPBQAFf2A0CjDehszapttZd4jqT/
         iipKJ3vkz4b9dkIUi7w3Iy3Po7/BnbswMFr2u3XcP9C7sCDmD/oPX0ZXxEylXMlt7cpu
         /EpM19gpiHrMrkwamI7dYvXN/daAG9NnhAC3wGNZV8S1A4pi55hRSanj4KJmyHW18wp7
         5lRg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770283090; x=1770887890; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7X94wcwqmm+LoFVA6eziIi5H+WCfNRJwZLfGEBUYiY=;
        b=R3jr4oO09w2Vgn2o73ol0PE6mFW/jj5yHkNSdUUb9LCoXsCRbvTk7B5FFBk43JjqNn
         H/710m5Ya2h30BhaHnBj0FfwwFtHf0rfaWR0DXvoa9X60xXzID75S9FVueRkopFYGNJW
         BqTw+XhYgUsm2/T90DJxnXAlZX+M1BnMgoBO+S0wt3Xh9XUdkG547rnNThMPBlXoD3kX
         eZvytpk/nQsNY+ZRu7AXWdgxQGApnpif3N05wEtv/PkTwUV7eVDKgFtQ6F6hR9pS/mWN
         YLrlwKuqe3Asn8CQnOd7ImVfbmsqDukBmlHunaLZshHZt5GauFsAcb6bj1+CxnFciLl8
         MCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770283090; x=1770887890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y7X94wcwqmm+LoFVA6eziIi5H+WCfNRJwZLfGEBUYiY=;
        b=foxqfoNII+fVvvZ4OHSGVb7ibGp/oPSH2plOzoxB8ob1gDRa7lBtNd1ys+w1HFJu6p
         +mmcHstumqLhtzs8ob6JX0thaepiJqg7MiJl/nTH7+BGsgwheTn+KevJ/njU0m1REbbF
         eI6w3/pRfxZuIMAvuLf3Zg4Xs/Pbw2hCJ7LVXo+0WSmmwcm6m38EOeFR/CyfCOiqQbMW
         1OGZRRBDCn4CYAmJsmnQAh1mH6L0W+hef+U5jG+X8Hs82oFDZYdyHliu26KxFHcBdUN5
         jKaNbJ79xfeqk5VUuBvCXF4qfEpIIOz9bbyPPVptaTnLXlRpnckMk2TuE8kTNiWRnVCt
         YFog==
X-Gm-Message-State: AOJu0YwE5alkSm6ohLL3wNnm5/ar+qoyLMnj2jqG9LNQW77cUDEDIBLB
	4tAx3TAJdwqGoab+SNNxmwFnhFbRJjE7SjYdBdIZMofC7OHjnT3x9sovCvXENahXew+Y9bUthDS
	f57KPzkdK3xODoFcBGLQUVV++U/hzubpcO810
X-Gm-Gg: AZuq6aIQGGbMOyX4y2iX5zIrdlmMK2/u4jl7E90yBYMBehLM4u4nrzvg4Fqzn60M3BH
	o7SHdnV0To1vT87SDwmk+Utyf1HlLSQcewx7PhzACrXnBxX9FnoHu1UHKF0Jeqzs5RjdReQ2iE+
	JziIm/r5YZ5XPIwozeZcvOZXSzvJ46QAIIHgb9tjVdSXj/ms5hvgs+pGh1HgxhF1GHhKYCGBWsa
	Uz0y3RoOSmtYaOlKZ32zzaBrs1l9m8d+kg5M8MD8f7GVh3KBTs1MmQQGldh9rTvzjll/ucY
X-Received: by 2002:a05:600c:c168:b0:47d:6f12:de57 with SMTP id
 5b1f17b1804b1-4830e96ae1bmr45648825e9.4.1770283089654; Thu, 05 Feb 2026
 01:18:09 -0800 (PST)
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
References: <20260203081639.954415-1-hsiangkao@linux.alibaba.com> <20260203082536.972454-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20260203082536.972454-1-hsiangkao@linux.alibaba.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Thu, 5 Feb 2026 17:17:58 +0800
X-Gm-Features: AZwV_Qg1qjwyDZd1qcd2bKs-u1DxrSF6u2BU7tqV8MkmQWWZHZREZzw_uWw5Lkg
Message-ID: <CAHJ8P3KugoiNU41YnqYKvrxioecXL_78LiaxRP2GM3Djvn+2CQ@mail.gmail.com>
Subject: Re: [PATCH v2] erofs: fix inline data read failure for ztailpacking pclusters
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, 
	oliver.yang@linux.alibaba.com, Zhiguo Niu <zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:oliver.yang@linux.alibaba.com,m:zhiguo.niu@unisoc.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[niuzhiguo84@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2263-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[niuzhiguo84@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: A3222F07FA
X-Rspamd-Action: no action

Gao Xiang <hsiangkao@linux.alibaba.com> =E4=BA=8E2026=E5=B9=B42=E6=9C=883=
=E6=97=A5=E5=91=A8=E4=BA=8C 16:26=E5=86=99=E9=81=93=EF=BC=9A
>
> Compressed folios for ztailpacking pclusters must be valid before adding
> these pclusters to I/O chains. Otherwise, z_erofs_decompress_pcluster()
> may assume they are already valid and then trigger a NULL pointer
> dereference.
>
> It is somewhat hard to reproduce because the inline data is in the same
> block as the tail of the compressed indexes, which are usually read just
> before. However, it may still happen if a fatal signal arrives while
> read_mapping_folio() is running, as shown below:
>
>  erofs: (device dm-1): z_erofs_pcluster_begin: failed to get inline data =
-4
>  Unable to handle kernel NULL pointer dereference at virtual address 0000=
000000000008
>
>  ...
>
>  pc : z_erofs_decompress_queue+0x4c8/0xa14
>  lr : z_erofs_decompress_queue+0x160/0xa14
>  sp : ffffffc08b3eb3a0
>  x29: ffffffc08b3eb570 x28: ffffffc08b3eb418 x27: 0000000000001000
>  x26: ffffff8086ebdbb8 x25: ffffff8086ebdbb8 x24: 0000000000000001
>  x23: 0000000000000008 x22: 00000000fffffffb x21: dead000000000700
>  x20: 00000000000015e7 x19: ffffff808babb400 x18: ffffffc089edc098
>  x17: 00000000c006287d x16: 00000000c006287d x15: 0000000000000004
>  x14: ffffff80ba8f8000 x13: 0000000000000004 x12: 00000006589a77c9
>  x11: 0000000000000015 x10: 0000000000000000 x9 : 0000000000000000
>  x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000000003f
>  x5 : 0000000000000040 x4 : ffffffffffffffe0 x3 : 0000000000000020
>  x2 : 0000000000000008 x1 : 0000000000000000 x0 : 0000000000000000
>  Call trace:
>   z_erofs_decompress_queue+0x4c8/0xa14
>   z_erofs_runqueue+0x908/0x97c
>   z_erofs_read_folio+0x128/0x228
>   filemap_read_folio+0x68/0x128
>   filemap_get_pages+0x44c/0x8b4
>   filemap_read+0x12c/0x5b8
>   generic_file_read_iter+0x4c/0x15c
>   do_iter_readv_writev+0x188/0x1e0
>   vfs_iter_read+0xac/0x1a4
>   backing_file_read_iter+0x170/0x34c
>   ovl_read_iter+0xf0/0x140
>   vfs_read+0x28c/0x344
>   ksys_read+0x80/0xf0
>   __arm64_sys_read+0x24/0x34
>   invoke_syscall+0x60/0x114
>   el0_svc_common+0x88/0xe4
>   do_el0_svc+0x24/0x30
>   el0_svc+0x40/0xa8
>   el0t_64_sync_handler+0x70/0xbc
>   el0t_64_sync+0x1bc/0x1c0
>
> Fix this by reading the inline data before allocating and adding
> the pclusters to the I/O chains.
>
> Fixes: cecf864d3d76 ("erofs: support inline data decompression")
> Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v2:
>  - Move folio_get() downwards to avoid reference count leak.
>
Hi Xiang,
thanks for this fix, so
Reviewed-and-tested-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
thanks!

>  fs/erofs/zdata.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 20d7df31a51f..ea9d32e9cb12 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -806,14 +806,26 @@ static int z_erofs_pcluster_begin(struct z_erofs_fr=
ontend *fe)
>         struct erofs_map_blocks *map =3D &fe->map;
>         struct super_block *sb =3D fe->inode->i_sb;
>         struct z_erofs_pcluster *pcl =3D NULL;
> -       void *ptr;
> +       void *ptr =3D NULL;
>         int ret;
>
>         DBG_BUGON(fe->pcl);
>         /* must be Z_EROFS_PCLUSTER_TAIL or pointed to previous pcluster =
*/
>         DBG_BUGON(!fe->head);
>
> -       if (!(map->m_flags & EROFS_MAP_META)) {
> +       if (map->m_flags & EROFS_MAP_META) {
> +               ret =3D erofs_init_metabuf(&map->buf, sb,
> +                                        erofs_inode_in_metabox(fe->inode=
));
> +               if (ret)
> +                       return ret;
> +               ptr =3D erofs_bread(&map->buf, map->m_pa, false);
> +               if (IS_ERR(ptr)) {
> +                       erofs_err(sb, "failed to read inline data %pe @ p=
a %llu of nid %llu",
> +                                 ptr, map->m_pa, EROFS_I(fe->inode)->nid=
);
> +                       return PTR_ERR(ptr);
> +               }
> +               ptr =3D map->buf.page;
> +       } else {
>                 while (1) {
>                         rcu_read_lock();
>                         pcl =3D xa_load(&EROFS_SB(sb)->managed_pslots, ma=
p->m_pa);
> @@ -853,18 +865,8 @@ static int z_erofs_pcluster_begin(struct z_erofs_fro=
ntend *fe)
>                 /* bind cache first when cached decompression is preferre=
d */
>                 z_erofs_bind_cache(fe);
>         } else {
> -               ret =3D erofs_init_metabuf(&map->buf, sb,
> -                                        erofs_inode_in_metabox(fe->inode=
));
> -               if (ret)
> -                       return ret;
> -               ptr =3D erofs_bread(&map->buf, map->m_pa, false);
> -               if (IS_ERR(ptr)) {
> -                       ret =3D PTR_ERR(ptr);
> -                       erofs_err(sb, "failed to get inline folio %d", re=
t);
> -                       return ret;
> -               }
> -               folio_get(page_folio(map->buf.page));
> -               WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, map->buf.pa=
ge);
> +               folio_get(page_folio((struct page *)ptr));
> +               WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, ptr);
>                 fe->pcl->pageofs_in =3D map->m_pa & ~PAGE_MASK;
>                 fe->mode =3D Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
>         }
> --
> 2.43.5
>
>

