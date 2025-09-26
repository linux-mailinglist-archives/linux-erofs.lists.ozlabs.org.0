Return-Path: <linux-erofs+bounces-1114-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4679BA2CBB
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Sep 2025 09:32:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cY2Ns3dWlz300F;
	Fri, 26 Sep 2025 17:32:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758871965;
	cv=none; b=ZyB2lMQPYXzJUx/3n7wHR9LJd3q5iqE/Ze5tlrQCPoeqR7jTmU8cNnyyuIwR1eKVrIzXPX6ZQP89W3FNF2me+4mSkVGHmvPzfQ2TqlAzcy+UiLYuHJQUfx26MuWy4cZRvaaiuJt6jRKXtunLmsf8ohbxn2e9oUacI22W64AXdjHy4UkJt2tPGq1ybpz6kYo3woFiQhtKfnlXEqVVsWI8OW38e2HXteunjf7yDoIZA551CQ5oxYBCELYaRrrp93ymcZSeMkR5BwdPssCuDDfrnypsAHHYnuLRcKf50gjDP4NtuOzm3anRTXvpe1XPEH1fmGKJWI5rM3XjmJw6KSZ2kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758871965; c=relaxed/relaxed;
	bh=K7lJCWxVdcfCha/v9DrcwqFYgZ0VcwRUn4ecEZCiSv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HusYDWKdGsUVB1FiVAtLrJEMXArtIuAWzemO2Jb8UZwnU1/RNCQ2GR+BvIgydzC8ae6nJ09v7XZsSM82ynAxdWpZ7XrbyCxemvI7X0aq2WrHWQ8Mb5R5lqytH0myKV2U3aXO98raJbhReGERPoTXL8P5QeayLGS9hd0gsHn+mzQxwPW4s6fwx3Nqr3w920C5PRT6T2ig7wit21Jr8+z5fYDdQyE2C7qlvTpCfpHhmOvrItqIPx6iasZRoDUYOu4J8z3OJCXYGOUyGZjnarfNb0Hj7/iM4tkrEgyGo5xJN9K31NOhZfJY3UEQNDGG5lGON6k/OffSmPwSg+qgL6I+ZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iqVzYAeh; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f2zI7cuU; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iqVzYAeh;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f2zI7cuU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cY2Nr57Xlz2ypW
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Sep 2025 17:32:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758871960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K7lJCWxVdcfCha/v9DrcwqFYgZ0VcwRUn4ecEZCiSv8=;
	b=iqVzYAehNJszn6+illvte8jcIxUk54jvUytI+5+g9gih7J7lEg20lljzSQWfH30ZpjQpGi
	ZemAl7/lH9YLlzDXNwIW8Qp7HqsgsufR6/S92Mmhfo4KVvbNu1brQb/BFDI/NEx8hkWIpS
	rdV6MMH5IZ27tW6InnDha6FlrWoAVVU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758871961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K7lJCWxVdcfCha/v9DrcwqFYgZ0VcwRUn4ecEZCiSv8=;
	b=f2zI7cuUT5rvbfqZttQn7QpUD7a4YRO/1+lw3n+R2CyhPKiGdOS8UVO7PeZCdBSZ7zOq9V
	Qd4t0k3Z2EEyRR7l+26hq3a5xQldarrgawfy5nCxxBGKkwRyo1+LJhd75toUfMwTmDYkCc
	qTHdW6LkS+ohXN4eOPyBxZHONBL+zPA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-ytHlgM9aMGSjLtomdfiq1Q-1; Fri, 26 Sep 2025 03:32:39 -0400
X-MC-Unique: ytHlgM9aMGSjLtomdfiq1Q-1
X-Mimecast-MFC-AGG-ID: ytHlgM9aMGSjLtomdfiq1Q_1758871958
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45de07b831dso11693175e9.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 26 Sep 2025 00:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758871958; x=1759476758;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7lJCWxVdcfCha/v9DrcwqFYgZ0VcwRUn4ecEZCiSv8=;
        b=l1gSZFnelRiwABJdRhKyPKJbp0+Zu7/Xr+xcFAECxaGKqF1U3zx1e+Tt4wyEz/Zdq+
         p+9VHqARTolluY3EtcdK8e8kzrqmjEgPn9I4miiliRBdXGHlBrWXW4cY5Hncc/0sQuNK
         yH+45oul7C1Eb1jb7GCd00ocKp3wpcorHw6yx/W1voC/fQJ+TfHkxx8iaJnR6GY01MqZ
         ZJpLxPg+Pv0EuH3sNHDPHWO/HhwpqkHMqXJ8rt4fRVrvXDst3K9o0zArVsHMxiiZacpa
         dMgqImQ3gB+YvdNvvsh8dEUFMLMJke5M9bvkJbunQNeissO7NmfxtVFwnVh+mPvsHrSp
         QTwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAITWTE4lZARndQT/KL7mhcszylVcZ8UWhPGtH7azZQKDSdbNLD5+YjynfmVAtg7vLgel5Sid0KRFBlw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzD7ka7cEwMJK0FlzB+oRv/rFzhJ0EUHhQ+r9Ekh33TkXUMkdQo
	JgEE6GOFhZm3JugzLBc/eMsqfevoXOxUAgUJPzY4OcvUPJqQdBjkz8iPY1HPooMiNUimKnzpPmK
	ctdqWH8LOKhkTWxcc6VzFopwWBImW+KJVmf78Idw/rUtBZTI29pEwWR8LmdWO2XbQ7A==
X-Gm-Gg: ASbGncvUsv3RSWRLZJfnKUfKTjnlMd241lgvhKWn27cZjigsgPfxouUfL47gcmYLHnT
	MW0nx4+xduoUtg0sxHAJruGzL0ckCeq6yjsgzRIc55+1GtV4aKm1P1154GLmLvwBsynkJLNcOVN
	41DznGZyCSDJry/sbXUhboISH9USqbJ3gCkAIFhxPpQ6M8OHx1C2jXwFtyc9L/hd3MACgm11dlS
	g8ATvRMZzrGz9VH1oX9IQIgD93aVcYS6OOP/LfJrZfLU7s+IqSzojh/6DEto4Qu55hKRIo8cr0I
	YnGjfah3dBG+dffFgmSfVqIg6+eGArqO0eKWz9OYG/SmIPydzcroPephNKnxDHwE4XDfaMuyWDi
	PzaFUy4pM8AhUf3KRMQy+ncwwe+g6lDry3xkVeN4KFHSBEZtviezNkcABa+2l+jhWxaui
X-Received: by 2002:a05:600c:a43:b0:46d:d949:daba with SMTP id 5b1f17b1804b1-46e329a7fe3mr62999005e9.4.1758871957541;
        Fri, 26 Sep 2025 00:32:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtL4vBtb4UkKxYY+8AUu50LpG2eTQL/mEdtyu+TBsZgjy08g9xtyeO4upwKha/FYi9Pburtw==
X-Received: by 2002:a05:600c:a43:b0:46d:d949:daba with SMTP id 5b1f17b1804b1-46e329a7fe3mr62997645e9.4.1758871956911;
        Fri, 26 Sep 2025 00:32:36 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f34:c100:5d3c:50c0:398a:3ac9? (p200300d82f34c1005d3c50c0398a3ac9.dip0.t-ipconnect.de. [2003:d8:2f34:c100:5d3c:50c0:398a:3ac9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc72b0aeesm6112695f8f.49.2025.09.26.00.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 00:32:36 -0700 (PDT)
Message-ID: <a127971f-d1e7-4fea-a16a-c2bae34b4ad3@redhat.com>
Date: Fri, 26 Sep 2025 09:32:32 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kvm-next V11 7/7] KVM: guest_memfd: selftests: Add tests
 for mmap and NUMA policy support
To: Jason Gunthorpe <jgg@nvidia.com>, Sean Christopherson <seanjc@google.com>
Cc: Shivank Garg <shivankg@amd.com>, willy@infradead.org,
 akpm@linux-foundation.org, pbonzini@redhat.com, shuah@kernel.org,
 vbabka@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk,
 dsterba@suse.com, xiang@kernel.org, chao@kernel.org, jaegeuk@kernel.org,
 clm@fb.com, josef@toxicpanda.com, kent.overstreet@linux.dev,
 zbestahu@gmail.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 lihongbo22@huawei.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, ziy@nvidia.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, tabba@google.com, ackerleytng@google.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz,
 bfoster@redhat.com, vannapurve@google.com, chao.gao@intel.com,
 bharata@amd.com, nikunj@amd.com, michael.day@amd.com, shdhiman@amd.com,
 yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, aik@amd.com, kalyazin@amazon.com, peterx@redhat.com,
 jack@suse.cz, hch@infradead.org, cgzones@googlemail.com,
 ira.weiny@intel.com, rientjes@google.com, roypat@amazon.co.uk,
 chao.p.peng@intel.com, amit@infradead.org, ddutile@redhat.com,
 dan.j.williams@intel.com, ashish.kalra@amd.com, gshan@redhat.com,
 jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com,
 yuzhao@google.com, suzuki.poulose@arm.com, quic_eberman@quicinc.com,
 linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20250827175247.83322-2-shivankg@amd.com>
 <20250827175247.83322-10-shivankg@amd.com> <aNW1l-Wdk6wrigM8@google.com>
 <20250925230420.GC2617119@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250925230420.GC2617119@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wV5n5lR0DbHaLkOQ6hPqma1o5OLwakx_1XR0z82MyWI_1758871958
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 26.09.25 01:04, Jason Gunthorpe wrote:
> On Thu, Sep 25, 2025 at 02:35:19PM -0700, Sean Christopherson wrote:
>>>   LDLIBS += -ldl
>>> +LDLIBS += -lnuma
>>
>> Hrm, this is going to be very annoying.  I don't have libnuma-dev installed on
>> any of my <too many> systems, and I doubt I'm alone.  Installing the package is
>> trivial, but I'm a little wary of foisting that requirement on all KVM developers
>> and build bots.
> 
> Wouldn't it be great if the kselftest build system used something like
> meson and could work around these little issues without breaking the
> whole build ? :(
> 
> Does anyone else think this?
> 
> Every time I try to build kselftsts I just ignore all the errors the
> fly by because the one bit I wanted did build properly anyhow.

When I'm in a hurry I even do the same within mm selftests.

-- 
Cheers

David / dhildenb


